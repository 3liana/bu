`timescale 1ns / 1ps

module stall(
	input [31:0] instr_D,
	input [4:0] WA_E,
	input [4:0] WA_M,
	input RegWr_E,
	input RegWr_M,
	input [1:0] Tnew_E,
	input [1:0] Tnew_M,
	input [1:0] Tnew_W,
	output stop
    );

	wire [5:0] op, func;
	assign op = instr_D[31:26];
	assign func = instr_D[5:0];
	wire addu, subu, ori, lui, lw, sw, beq, j, jal, jr;
	wire jalr,bgtz,lb,sb,sh,lh,bgezalr,clz;
	decoder deinstr(op,func,addu, subu, ori, lui, lw, sw, beq, j, jal, jr,jalr,bgtz,lb,sb,sh,lh,bgezalr,clz);

	
	wire Tuse_RS0, Tuse_RS1, Tuse_RT0, Tuse_RT1, Tuse_RT2;
	assign Tuse_RS0 = lui|beq|jr|jal|j|bgezalr;
	assign Tuse_RS1 = addu|subu|ori|lw|sw|sh|clz;
	assign Tuse_RT0 = ori|lw|beq|jr|jal|j|bgezalr;
	assign Tuse_RT1 = addu|subu|lui;
	assign Tuse_RT2 = sw|sh;

	wire [4:0] A1_D, A2_D; 
	assign A1_D = instr_D[25:21];
	assign A2_D = instr_D[20:16];

	wire stall_rs0_e1, stall_rs0_e2, stall_rs0_m1, stall_rs1_e2;
	wire stall_rt0_e1, stall_rt0_e2, stall_rt0_m1, stall_rt1_e2;
	wire stall_rs, stall_rt;
	assign stall_rs0_e1 = Tuse_RS0 & (Tnew_E == 2'b01) & (A1_D==WA_E) & (A1_D!=0) & RegWr_E;
	assign stall_rs0_e2 = Tuse_RS0 & (Tnew_E == 2'b10) & (A1_D==WA_E) & (A1_D!=0) & RegWr_E;
	assign stall_rs0_m1 = Tuse_RS0 & (Tnew_M == 2'b01) & (A1_D==WA_M) & (A1_D!=0) & RegWr_M;
	assign stall_rs1_e2 = Tuse_RS1 & (Tnew_E == 2'b10) & (A1_D==WA_E) & (A1_D!=0) & RegWr_E;
	assign stall_rs = stall_rs0_e1 | stall_rs0_e2 | stall_rs0_m1 | stall_rs1_e2;
	
	assign stall_rt0_e1 = Tuse_RT0 & (Tnew_E == 2'b01) & (A2_D==WA_E) & (A2_D!=0) & RegWr_E;
	assign stall_rt0_e2 = Tuse_RT0 & (Tnew_E == 2'b10) & (A2_D==WA_E) & (A2_D!=0) & RegWr_E;
	assign stall_rt0_m1 = Tuse_RT0 & (Tnew_M == 2'b01) & (A2_D==WA_M) & (A2_D!=0) & RegWr_M;
	assign stall_rt1_e2 = Tuse_RT1 & (Tnew_E == 2'b10) & (A2_D==WA_E) & (A2_D!=0) & RegWr_E;
	assign stall_rt = stall_rt0_e1 | stall_rt0_e2 | stall_rt0_m1 | stall_rt1_e2;
	
	assign stop = stall_rs|stall_rt;
	
endmodule
