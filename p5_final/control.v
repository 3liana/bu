`timescale 1ns/1ns
`include "head.v"
module Control(
	input [31:0] Instr_D,
	input judge,
	output PC_sel,
	output [1:0] EXTCtrl,
	output [1:0] MemtoReg_D,
	output [1:0] RegDst_D,
	output [2:0] CMPctr,
	output [2:0] ALUCtrl_D,
	output [2:0] PCSrc,
	output MemWr_D,
	output ALUSrc_D,
	output RegWr_D
);

wire [5:0] op = Instr_D[`op];
wire [5:0] func = Instr_D[`func];
wire [4:0] rt = Instr_D[`rt];

wire addu, subu, ori, lui, lw, sw, beq, j, jal, jr;
wire jalr,bgtz,lb,sb,sh,lh,bgezalr,clz;
decoder deInstr_D(op,func,addu, subu, ori, lui, lw, sw, beq, j, jal, jr,jalr,bgtz,lb,sb,sh,lh,bgezalr,clz);

assign EXTCtrl = (sw | lw | lb | lh | sh) ? `EXT_SIGN :
								(lui) ? `EXT_LUI :
 						 (beq | bgtz) ? `EXT_B:
							             `EXT_ZERO;

assign MemtoReg_D = (lw) ? `MtR_MD:
					  (jal | bgezalr) ? `MtR_PC8:
				      (lb) ? `MtR_:
				             `MtR_ALUout;

assign MemWr_D = (sw | sb | sh);

assign CMPctr = (bgezalr) ? 3'b001 : 3'b000;


assign PC_sel = (((beq| bgtz|bgezalr)&&judge)|j|jal|jr);

assign ALUCtrl_D = (subu) ? `ALU_SUBU:
					(ori) ? `ALU_OR:
					(clz) ? `ALU_CLZ:
							`ALU_ADDU;

assign ALUSrc_D = (lb | sw | lw | ori | lui | bgtz | lh | sb | sh);
assign RegDst_D = (lw | ori | lui | lb) ? `WA_RT:
								   (jal) ? `WA_31:
				                           `WA_RD;


assign RegWr_D = (addu | subu | lw | ori | lb | lui | jal | jalr | lh | bgezalr |clz) ;

assign PCSrc = (beq | bgtz ) ? 3'b001:
					(j | jal) ? 3'b010:
			      (jr | jalr) ? 3'b011:
			      	(bgezalr) ? 3'b100:
				       			 3'b0;

endmodule