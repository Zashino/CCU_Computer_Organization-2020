`timescale 1ns/1ps

module INSTRUCTION_FETCH(
	clk,
	rst,
	jump,
	branch,
	jump_addr,
	branch_addr,

	PC,
	IR
);

input clk, rst, jump, branch;
input [31:0] jump_addr, branch_addr;

output reg 	[31:0] PC;
output reg 	[31:0] IR;

reg [31:0] instruction [255:0];
//output instruction
always @(posedge clk or posedge rst)
begin
	if(rst) begin
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
		cpu.IF.instruction[93] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[94] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[95] = 32'b000000_00000_00000_00000_00000_100000;
	end
	else begin
		if (PC[10:2] <= 8'd95)
			IR <= instruction[PC[10:2]];
end

// output program counter
always @(posedge clk or posedge rst)
begin
	if(rst)
		PC <= 32'd0;
	else begin
		if(PC[10:2] < 8'd125)
			PC <= (branch) ? branch_addr : ( (jump) ? jump_addr : (PC+4)) ;
	end
end

endmodule