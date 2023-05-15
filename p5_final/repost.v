`timescale 1ns / 1ps
`define E2D 2'b11 //3
`define M2D 2'b10 //2
`define W2D 2'b01	//1
`define ORIGIN 2'b00

`include "head.v"
module repost(
	input [31:0] instr_D,
	input [4:0] A3_E,
	input [4:0] A3_M,
	input [4:0] A3_W,
	input [4:0] A1_E,
	input [4:0] A2_E,
	input [4:0] A2_M,
	input MemWr_D,
	input RegWr_E,
	input RegWr_M,
	input RegWr_W,
	input [1:0] T_new_E,
	input [1:0] T_new_M,
	output [1:0] D_RS_CTRL,
	output [1:0] D_RT_CTRL,
	output [1:0] ALU_op1_Ctrl,
	output [1:0] ALU_op2_Ctrl,
	output DM_Ctrl
    );
	
	wire [4:0] A1_D, A2_D;
	assign A1_D = instr_D[`rs];
	assign A2_D = instr_D[`rt];
	
	assign D_RS_CTRL = ((A1_D == A3_E) & (A3_E!=0) & (T_new_E == 0) &RegWr_E)? `E2D:
							 ((A1_D == A3_M) & (A3_M!=0) & (T_new_M == 0) &RegWr_M)? `M2D:
							 ((A1_D == A3_W) & (A3_W!=0) &                 RegWr_W)? `W2D:
						                                                         `ORIGIN;
	
	assign D_RT_CTRL = ((A2_D == A3_E) & (A3_E!=0) & (T_new_E == 0) &RegWr_E)? `E2D:
							 ((A2_D == A3_M) & (A3_M!=0) & (T_new_M == 0) &RegWr_M)? `M2D:
							  ((A2_D == A3_W) & (A3_W!=0)                 &RegWr_W)? `W2D:
						//((A2_D == 5'h1f) 									  &MemWr_D)? `M2D:	//jal
						                                                          `ORIGIN;
	
	assign ALU_op1_Ctrl = ((A1_E == A3_M) & (A3_M!=0) & (T_new_M == 0) &RegWr_M)? `M2D:
													  ((A1_E == A3_W) & (A3_W!=0) & RegWr_W)? `W2D:
						 //((A1_E == 5'h1f) 									&RegWr_W)? `W2D:	//jal
						                                                            `ORIGIN;
	
	assign ALU_op2_Ctrl = ((A2_E == A3_M) & (A3_M!=0) & (T_new_M == 0) &RegWr_M)? `M2D:
														 ((A2_E == A3_W) & (A3_W!=0)&RegWr_W)? `W2D:
						 //((A2_E == 5'h1f) 									&RegWr_W)? `W2D:	//jal
																										`ORIGIN;
	
	assign DM_Ctrl = ((A2_M == A3_W) & (A3_W!=0) & RegWr_W)? 1 : 0;

endmodule
