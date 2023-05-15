`timescale 1ns/1ns
`include "head.v"
module nPC(
	input [31:0] PC_F,
	input [31:0] E32_D,
	input [31:0] V1,
	input [31:0] V2,
	input [31:0] Instr_D,
	input judge,
	input[2:0] PCSrc,
	output [31:0] nPC
);
	wire [31:0] nPC_1;
	wire pc_4 = PC_F + 4;

	nPC_1 my_nPC_1(.E32_D(E32_D),.PC(PC_F),.judge(judge),.nPC_1(nPC_1));

	wire [31:0] nPC_2 = {PC_F[31:28],Instr_D[25:0],2'b00};

	wire [31:0] nPC_3 = V1;

	wire [31:0]	nPC_4 = V2;

	assign nPC = (PCSrc == `NPC_B) ? nPC_1:
				 (PCSrc == `NPC_JAL) ? nPC_2:
				 (PCSrc == `NPC_RS) ? nPC_3:
				 (PCSrc == `NPC_RT) ? nPC_4:
				                    pc_4;

endmodule

module nPC_1(
	input [31:0] E32_D,
	input [31:0] PC,
	input judge,
	output [31:0] nPC_1
);
	assign nPC_1 = (judge) ? (E32_D + PC) : (PC + 4);

endmodule