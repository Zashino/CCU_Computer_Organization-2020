#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#define Date_read 0
#define Data_write 1
#define FIFO 1
#define LRU 2
typedef struct {
    char *file_name;
    long fetch_cnt;
    long hit_cnt;
    long miss_cnt;
    double miss_rate;
    long read_cnt;
    long write_cnt;
    long byte_from_mem;
    long byte_to_mem;
}ANS_table;
typedef struct _CacheLine{
    int valid;
    int tag;
    int dirty;
    int priority;
    struct _CacheLine *next;
}CacheLine;
void ANS_init(ANS_table *ANS)
{
    ANS->fetch_cnt = 0;
    ANS->hit_cnt = 0;
    ANS->miss_cnt = 0;
    ANS->read_cnt = 0;
    ANS->write_cnt = 0;
    ANS->byte_from_mem = 0;
    ANS->byte_to_mem = 0;
}
void CacheTLB_init(CacheLine *CacheTLB, int TLB_Size, int associativity)
{
    for (int i=0; i<TLB_Size; i++) {
        CacheTLB[i].valid = 0;
        CacheTLB[i].tag = 0;
        CacheTLB[i].dirty = 0;
        CacheTLB[i].priority = 0;
        CacheTLB[i].next = NULL;
        CacheLine *ptr = &CacheTLB[i];
        for(int j=1; j<associativity; j++){
            CacheLine *node;
            node = (CacheLine *)malloc(sizeof(CacheLine));
            node->valid = 0;
            node->tag = 0;
            node->dirty = 0;
            node->priority = j;
            node->next = NULL;
            ptr->next = node;
            ptr = ptr->next;
        }
    }
}
int fetch(char *line, FILE *fp)
{
    if (fgets(line, 100 ,fp) != NULL)
        return 0;
    else
        return -1;
}
int Read_Label(char *ptr)
{
    return (int)*ptr-48;
}
long Read_Address(char *ptr)
{
    long Address;
    ptr += 2;
    Address = strtol(ptr, NULL, 16);
    return Address;
}
int dirty_to_mem(CacheLine *CacheTLB, ANS_table ANS, int TLB_Size, int associativity)
{
    CacheLine *Cacheptr;
    for (int i=0; i<TLB_Size; i++) {  //put remain dirty to mem
        Cacheptr = CacheTLB+i;
        for (int j=1; j<=associativity; j++) {
            if (Cacheptr->dirty == 1) {
                ANS.byte_to_mem++;
            }
            Cacheptr = Cacheptr->next;
        }
    }
    return ANS.byte_to_mem;
}
void printANS(ANS_table ANS)
{
    printf("Input file = %s\n",ANS.file_name);
    printf("Demand fetch = %ld\n",ANS.fetch_cnt);
    printf("Cache hit = %ld\n",ANS.hit_cnt);
    printf("Cache miss = %ld\n",ANS.miss_cnt);
    ANS.miss_rate = (double)ANS.miss_cnt/(double)ANS.fetch_cnt;
    printf("Miss rate = %.4f\n",ANS.miss_rate);
    printf("Read date = %ld\n",ANS.read_cnt);
    printf("Write date = %ld\n",ANS.write_cnt);
    printf("Bytes from memory = %ld\n",ANS.byte_from_mem);
    printf("Bytes to memory = %ld\n",ANS.byte_to_mem);
}
int main(int argc, char *argv[])
{
    if(argc < 6){
        printf("Insufficient arguments\n");
        return 0;
    }
    //open file
    FILE *fp;
    fp = fopen(argv[5], "r");
    //init ANS
    ANS_table ANS;
    ANS_init(&ANS);
    ANS.file_name = strdup(argv[5]);

    //creatTLB
    int Cache_Size = atoi(argv[1]) * 1024;
    int Cache_Block = atoi(argv[2]);
    int associativity;
    (strcmp(argv[3], "f") == 0) ? (associativity = Cache_Size/Cache_Block) : (associativity = atoi(argv[3]));
    int TLB_Size = Cache_Size/Cache_Block/associativity;
    CacheLine CacheTLB[TLB_Size];
    CacheTLB_init(CacheTLB, TLB_Size, associativity);

    //mode
    int mode;
    if(strcmp(argv[4], "FIFO") == 0)
        mode = FIFO;
    else if(strcmp(argv[4], "LRU") == 0)
        mode = LRU;

    //Start to fetch demand
    char line[100];
    CacheLine *Cacheptr;
    while (fetch(line, fp) != -1) {
        int Label, tag, index, offset;
        long Address;
        Label = Read_Label(line);
        Address = Read_Address(line);
        //tag|index|offset
        offset = Cache_Block;
        index = (Address/offset)%TLB_Size;
        tag = (Address/offset)/TLB_Size;
        //------start cache behavior------
        ANS.fetch_cnt++;
        if (Label == Date_read)
            ANS.read_cnt++;
        else if (Label == Data_write)
            ANS.write_cnt++;
        //-----if not valid-----
        Cacheptr = &CacheTLB[index];
        while (Cacheptr != NULL) {
            if (Cacheptr->valid == 0) {
                Cacheptr->valid = 1;
                Cacheptr->tag = tag;
                Cacheptr->priority = associativity;
                if (Label == Data_write) {
                    Cacheptr->dirty = 1;
                }
                ANS.miss_cnt++;
                ANS.byte_from_mem++;
                //priority--
                CacheLine *Cacheqtr;
                Cacheqtr = &CacheTLB[index];
                for (int i=1; i<=associativity; i++) {
                    Cacheqtr->priority--;
                    Cacheqtr = Cacheqtr->next;
                }
                break;
            }
            //------if valid-----
            if (Cacheptr->tag == tag) {     //hit
                if (Label == Data_write)
                    Cacheptr->dirty = 1;
                if (mode == LRU) {
                    int temp;
                    temp = Cacheptr->priority;
                    Cacheptr->priority = associativity;
                    CacheLine *Cacheqtr;
                    Cacheqtr = &CacheTLB[index];
                    for (int i=1; i<=associativity; i++) {
                        if (Cacheqtr->priority > temp)
                            Cacheqtr->priority--;
                        Cacheqtr = Cacheqtr->next;
                    }
                }
                ANS.hit_cnt++;
                break;
            }
            Cacheptr = Cacheptr->next;
        }
        if (Cacheptr == NULL) {             //miss
            Cacheptr = &CacheTLB[index];
            while (Cacheptr != NULL) {
                if (Cacheptr->priority == 0) {
                    Cacheptr->tag = tag;
                    Cacheptr->priority = associativity;
                    ANS.miss_cnt++;
                    ANS.byte_from_mem++;
                    if (Cacheptr->dirty == 1) { //miss & to mem
                        ANS.byte_to_mem++;
                    }
                    if (Label == Data_write)
                            Cacheptr->dirty = 1;
                    else
                        Cacheptr->dirty = 0;
                    break;
                }
                Cacheptr = Cacheptr->next;
            }
            //priority--
            Cacheptr = &CacheTLB[index];
            for (int i=1; i<=associativity; i++) {
                Cacheptr->priority--;
                Cacheptr = Cacheptr->next;
            }
        }
    }
    ANS.byte_to_mem = dirty_to_mem(CacheTLB, ANS, TLB_Size, associativity);
    //------OUTPUT-------
    ANS.byte_from_mem *= Cache_Block;
    ANS.byte_to_mem *= Cache_Block;
    printANS(ANS);
}
