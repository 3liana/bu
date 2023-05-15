`timescale 1ns / 1ps

`include "head.v"
module mips(
    input clk,
    input reset
    );

	//F part
	wire stop;
	wire [31:0] pc_F, pc_D, pc_E, pc_M, pc_W, npc_F, npc_D;
	wire [31:0] instr_F, instr_D, instr_E, instr_M;
	//control
	wire judge, PC_sel, ALUSrc_D, ALUSrc_E;
	wire RegWr_D, MemWr_D, RegWr_E, MemWr_E, RegWr_M, MemWr_M, RegWr_W;
	wire [1:0] RegDst, MemtoReg_D, MemtoReg_E, MemtoReg_M, MemtoReg_W, EXTCtrl;
	wire [2:0] PCSrc, ALUctr_D, ALUctr_E, CMPCtr;
	//GRF_Reg Part
	wire [4:0] A1_D, A2_D, A3_D, A1_E, A2_E, A3_E, A2_M, A3_M, A3_W;
	wire [4:0] RD_D, RT_D;
	wire [31:0] V1_D, V2_D, E32_D, V1_E, V2_E, E32_E, V2_M;
	//D part
	wire [15:0] Imm16_D;
	wire [25:0] Imm26_D;
	wire [31:0] RD1_D, RD2_D;
	//E part
	wire [31:0] ALU_A, ALU_B, pre_ALU_B, AO_E, AO_M, AO_W, AOM_PC8;
	//M part
	wire [31:0] DataSave_M, DR_M, DR_W;
	//W part
	wire [31:0] WD_W;
	//Hazard part
	wire [1:0] Tnew_E, Tnew_M, Tnew_W;
	//Forward part
	wire DM_Ctrl;
	wire [1:0] D_RS_CTRL, D_RT_CTRL, ALU_op1_Ctrl, ALU_op2_Ctrl;

////////////////////////////////////////////////////////////////////////////////////////////
// F part
	MUX_2to1_32b F_MPC ( (pc_F+32'h4), npc_D, PC_sel, 
							npc_F); 

	PC F_pc (clk, reset, stop, npc_F, 
			   pc_F);
	IM F_im (pc_F,
			   instr_F);
	
	F_D D_reg (clk, reset, stop, pc_F, instr_F,
					 pc_D, instr_D);

//D part
	Control D_ctr (instr_D, judge,
							PC_sel, EXTCtrl, MemtoReg_D,RegDst,
							CMPCtr,ALUctr_D,PCSrc,MemWr_D,ALUSrc_D,RegWr_D);
	
	assign A1_D = instr_D[`rs];
	assign A2_D = instr_D[`rt];
	assign Imm16_D = instr_D[15:0];
	assign Imm26_D = instr_D[25:0];
	
	//Forward D choose V1_D, V2_D
	MUX_4to1_32b D_MFRD1 ( RD1_D, WD_W, AOM_PC8, V1_E,D_RS_CTRL,
								V1_D);							
	MUX_4to1_32b D_MFRD2 ( RD2_D, WD_W, AOM_PC8, V2_E,D_RT_CTRL,
								V2_D);	
	
	nPC D_npc (pc_F, E32_D, V1_D, V2_D, instr_D, judge, PCSrc, 
				   npc_D);
	
	GRF D_grf (clk, reset, RegWr_W, A1_D, A2_D, A3_W, WD_W, pc_W,
				  RD1_D, RD2_D);
	
	CMP D_cmp (V1_D, V2_D, CMPCtr, judge);
	
	EXT D_ext (Imm16_D, EXTCtrl, 
				  E32_D);
	
	assign RD_D = instr_D[`rd];
	assign RT_D = instr_D[`rt];
	MUX_3to1_5b D_MA3 ( RD_D, RT_D, 5'h1f, RegDst,
								A3_D);
	
	D_E E_reg (clk, reset, stop,
					  pc_D, V1_D, V2_D, A1_D, A2_D, A3_D, E32_D, ALUctr_D, ALUSrc_D, MemtoReg_D, RegWr_D, MemWr_D, instr_D,
					  pc_E, V1_E, V2_E, A1_E, A2_E, A3_E, E32_E, ALUctr_E, ALUSrc_E, MemtoReg_E, RegWr_E, MemWr_E, instr_E,
					  Tnew_E);
	
//E part
	//Forward E choose ALU_A, ALU_B
	MUX_3to1_32b E_ALUA ( V1_E, WD_W, AOM_PC8,ALU_op1_Ctrl,
								   ALU_A);
	MUX_3to1_32b E_ALUBP ( V2_E, WD_W, AOM_PC8,ALU_op2_Ctrl,
								    pre_ALU_B);
						
	MUX_2to1_32b E_ALUB ( pre_ALU_B, E32_E,ALUSrc_E,
								ALU_B);
	
	ALU E_alu (ALUctr_E, ALU_A, ALU_B,
				  AO_E);
				  
	E_M M_reg (clk, reset,
						instr_E, pc_E, pre_ALU_B, A2_E, AO_E, A3_E, MemtoReg_E, RegWr_E, MemWr_E, Tnew_E,	
						instr_M, pc_M, V2_M, A2_M, AO_M, A3_M, MemtoReg_M, RegWr_M, MemWr_M, Tnew_M);
	
//M part
	//Foward M choose DR_M
	MUX_2to1_32b M_MFWD( V2_M, WD_W, DM_Ctrl, DataSave_M); 
	
	DM M_dm (reset, clk, MemWr_M, instr_M, AO_M, DataSave_M, pc_M, DR_M);
		
	MUX_2to1_32b M_MWBD( AO_M, (pc_M+8), (MemtoReg_M == `MtR_PC8),
							 AOM_PC8);
		
		
	M_W W_reg (clk, reset,
					  pc_M, A3_M, AO_M, DR_M, MemtoReg_M, RegWr_M, Tnew_M,
					  pc_W, A3_W, AO_W, DR_W, MemtoReg_W, RegWr_W, Tnew_W);
				
//W part
	MUX_3to1_32b W_MRFWD ( AO_W, DR_W, (pc_W+32'h8),MemtoReg_W,
								  WD_W);

///////////////////////////////////////////////////////////////////////////
//HAZARD part
	stall stop_module (instr_D, A3_E, A3_M, RegWr_E, RegWr_M,
							  Tnew_E, Tnew_M, Tnew_W,
							  stop);

//FORWARD part
	repost Repost_module(instr_D, A3_E, A3_M, A3_W, A1_E, A2_E, A2_M,
									  MemWr_D, RegWr_E, RegWr_M, RegWr_W, Tnew_E, Tnew_M,
									  D_RS_CTRL, D_RT_CTRL, ALU_op1_Ctrl, ALU_op2_Ctrl, DM_Ctrl);

endmodule
