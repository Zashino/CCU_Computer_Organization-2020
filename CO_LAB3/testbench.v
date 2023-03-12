`define CYCLE_TIME 20
`define INSTRUCTION_NUMBERS 350
`timescale 1ns/1ps
`include "CPU.v"

module testbench;
reg Clk, Rst;
reg [31:0] cycles, i;

// Instruction DM initialilation
initial
begin
	/*=================================================     連加     =================================================*/
		cpu.IF.instruction[ 0] = 32'b100011_00000_01000_00000_00000_000000;//lw X
		cpu.IF.instruction[ 1] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 4] = 32'b000000_01000_00001_01001_00000_100010;//sub $t2,$t1,1
		cpu.IF.instruction[ 5] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 6] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 7] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 8] = 32'b000000_01001_00010_01010_00000_011010;//div $t3,$t2,2 loopA
		cpu.IF.instruction[ 9] = 32'b000000_00000_00010_00011_00000_100000;//add $t4,$zero,2
		cpu.IF.instruction[10] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[11] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[12] = 32'b000000_01010_00001_01010_00000_100000;//add $t3,$t3,1
		cpu.IF.instruction[13] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[14] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[15] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[16] = 32'b000000_01001_00011_10000_00000_011011;//rem $t0,$t2,$t4 Loop1
		cpu.IF.instruction[17] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[18] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[19] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[20] = 32'b000100_00010_01001_00000_00000_011100;//beq A=2
		cpu.IF.instruction[21] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[22] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[23] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[24] = 32'b000000_00011_00001_00011_00000_100000;//A3++
		cpu.IF.instruction[25] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[26] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[27] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[28] = 32'b000100_00000_10000_00000_00000_001011;//beq $t0,$zero,Anotprime
		cpu.IF.instruction[29] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[30] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[31] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[32] = 32'b000100_01010_00011_00000_00000_001111;//beq $t4,$t3,Aisprime
		cpu.IF.instruction[33] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[34] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[35] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[36] = 32'b000010_00000_00000_00000_00000_010000;//J loop1
		cpu.IF.instruction[37] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[38] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[39] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[40] = 32'b000000_01001_00001_01001_00000_100010;//A--
		cpu.IF.instruction[41] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[42] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[43] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[44] = 32'b000010_00000_00000_00000_00000_001000;//J loopA
		cpu.IF.instruction[45] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[46] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[47] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[48] = 32'b101011_00000_01001_00000_00000_000001;//Aisprime: sw
		cpu.IF.instruction[49] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[50] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[51] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[52] = 32'b000000_01000_00001_01011_00000_100000;//add $t4,$t1,1
		cpu.IF.instruction[53] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[54] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[55] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[56] = 32'b000000_01011_00010_01100_00000_011010;//div $t5,$t4,2 loopB:
		cpu.IF.instruction[57] = 32'b000000_00000_00010_00011_00000_100000;//add $t6,$zero,2
		cpu.IF.instruction[58] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[59] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[60] = 32'b000000_01011_00001_01011_00000_100000;//add $t5,$t5,1
		cpu.IF.instruction[61] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[62] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[63] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[64] = 32'b000000_01011_00011_10000_00000_011011;//rem $t0,$t4,$t6 loop2
		cpu.IF.instruction[65] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[66] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[67] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[68] = 32'b000000_00011_00001_00011_00000_100000;//add $t6,$t6,1
		cpu.IF.instruction[69] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[70] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[71] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[72] = 32'b000100_00000_10000_00000_00000_001011;//beq $t0,$zero,Bnotprime
		cpu.IF.instruction[73] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[74] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[75] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[76] = 32'b000100_00011_01100_00000_00000_001111;//beq $t6,$t5,Bisprime
		cpu.IF.instruction[77] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[78] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[79] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[80] = 32'b000010_00000_00000_00000_00001_000000;//j loop2
		cpu.IF.instruction[81] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[82] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[83] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[84] = 32'b000000_01011_00001_01011_00000_100000;//B++
		cpu.IF.instruction[85] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[86] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[87] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[88] = 32'b000010_00000_00000_00000_00000_111000;//j loopB
		cpu.IF.instruction[89] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[90] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[91] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[92] = 32'b101011_00000_01011_00000_00000_000010;//Bisprime: sw
		
		for (i=93; i<128; i=i+1)  cpu.IF.instruction[ i] = 32'b000000_00000_00000_00000_00000_100000;		//NOP(add $0, $0, $0)
		cpu.IF.PC = 0;
		
		
		
	
end

// Data Memory & Register Files initialilation
initial
begin
	cpu.MEM.DM[0] = 32'd13;
	for (i=1; i<128; i=i+1) cpu.MEM.DM[i] = 32'b0;
	
	cpu.ID.REG[0] = 32'd0;
	cpu.ID.REG[1] = 32'd1;
	cpu.ID.REG[2] = 32'd2;
	cpu.ID.REG[3] = 32'd2;

	for (i=4; i<32; i=i+1) cpu.ID.REG[i] = 32'b0;
	
	


end

//clock cycle time is 20ns, inverse Clk value per 10ns
initial Clk = 1'b1;
always #(`CYCLE_TIME/2) Clk = ~Clk;

//Rst signal
initial begin
	cycles = 32'b0;
	Rst = 1'b1;
	#12 Rst = 1'b0;
end

CPU cpu(
	.clk(Clk),
	.rst(Rst)
);

//display all Register value and Data memory content
always @(posedge Clk) begin
	cycles <= cycles + 1;
	if (cycles == `INSTRUCTION_NUMBERS) $finish; // Finish when excute the 24-th instruction (End label).
	$display("PC: %d cycles: %d", cpu.FD_PC>>2 , cycles);
	$display("  R00-R07: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[0], cpu.ID.REG[1], cpu.ID.REG[2], cpu.ID.REG[3],cpu.ID.REG[4], cpu.ID.REG[5], cpu.ID.REG[6], cpu.ID.REG[7]);
	$display("  R08-R15: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[8], cpu.ID.REG[9], cpu.ID.REG[10], cpu.ID.REG[11],cpu.ID.REG[12], cpu.ID.REG[13], cpu.ID.REG[14], cpu.ID.REG[15]);
	$display("  R16-R23: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[16], cpu.ID.REG[17], cpu.ID.REG[18], cpu.ID.REG[19],cpu.ID.REG[20], cpu.ID.REG[21], cpu.ID.REG[22], cpu.ID.REG[23]);
	$display("  R24-R31: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[24], cpu.ID.REG[25], cpu.ID.REG[26], cpu.ID.REG[27],cpu.ID.REG[28], cpu.ID.REG[29], cpu.ID.REG[30], cpu.ID.REG[31]);
	$display("  0x00   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[0],cpu.MEM.DM[1],cpu.MEM.DM[2],cpu.MEM.DM[3],cpu.MEM.DM[4],cpu.MEM.DM[5],cpu.MEM.DM[6],cpu.MEM.DM[7]);
	$display("  0x08   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[8],cpu.MEM.DM[9],cpu.MEM.DM[10],cpu.MEM.DM[11],cpu.MEM.DM[12],cpu.MEM.DM[13],cpu.MEM.DM[14],cpu.MEM.DM[15]);
end

//generate wave file, it can use gtkwave to display
initial begin
	$dumpfile("cpu_hw.vcd");
	$dumpvars;
end
endmodule

