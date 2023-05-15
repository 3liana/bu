`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:26:27 11/05/2022 
// Design Name: 
// Module Name:    mips 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mips(
    input clk,
    input reset
    );
	 wire branch,iszero,jump,jumpreg,alusrc,regwrite,memwrite;
	 wire [1:0] regdst,memtoreg,extop;
	 wire [2:0] aluctr;
	 wire [4:0] rs,rt,rd,writereg;
	 wire [5:0] op,func;
	 wire [15:0] imm;
	 wire [25:0] ins25;
	 wire [31:0] pc,read1,read2,npc,extout,plus4,writedata,input1,input2,aluout,memout,memdata;
    assign plus4 = pc + 4;
	 
	 NPC npc1(pc,extout,branch,iszero,jump,jumpreg,read1,ins25,npc);
	 PC pc1(npc,clk,reset,pc);
	 IM im1(pc,ins25,op,func,rs,rt,rd,imm);
	 control control1(func,op,regdst,alusrc,memtoreg,regwrite,memwrite,branch,extop,aluctr,jump,jumpreg);
	 regmux regmux1(rt,rd,regdst,writereg);
	 ext ext1(imm,extop,extout);
	 GRF grf1(clk,reset,regwrite,rs,rt,writereg,writedata,pc,read1,read2);
	 assign input1 = read1;
	 alumux1 alumux1_1(read2,extout,alusrc,input2);
	 ALU alu1(input1,input2,aluctr,aluout,iszero);
	 assign memdata = read2;
	 DM dm1(clk,reset,memwrite,aluout,pc,memdata,memout);
	 memmux memmux1(aluout,memout,plus4,memtoreg,writedata);
endmodule
