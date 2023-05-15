`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:01:25 11/16/2022 
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
	 ///////////////////////////////////
	 // wire all
	  wire [1:0] Tuse_rsD,Tuse_rtD,TnewD,TnewE,TnewM;
	     //control
	  wire [5:0] op,func;
	  wire regWriteD,memToRegD,memWriteD,aluSrcD,regDstD,branchD,jalOpD,jrOpD;
	  wire [3:0] aluCtrD;
	  wire [2:0] extOpD;
	    //F
	  wire [31:0] pcPlus4F,pcBranchD,pcJumpD,npc,pcF,instrF;
	  wire pcSrcD;
	    //D
	  wire [31:0] instrD,pcD,pcPlus4D,imm32D;
	  wire equalD;
	  wire [4:0] rsD,rtD,rdD;
	  wire [15:0]imm = instrD[15:0];
	  wire [31:0] data1,data2,rd1D,rd2D;
	    //E
	  wire regWriteE,memToRegE,memWriteE,aluSrcE,regDstE,jalOpE;
	  wire [3:0] aluCtrE;
	  wire [4:0] rsE,rtE,rdE;
	  wire [31:0] rd1E,rd2E,imm32E,pcE;
	  wire [31:0] in1E,rd2True,in2E,aluOutE_0,aluOutE;
	  wire [4:0] writeRegE;
	    //M
	  wire regWriteM,memToRegM,memWriteM,jalOpM;
	  wire [31:0] aluOutM,writeDataM,pcM;
	  wire [4:0] writeRegM;
	  wire [31:0] loadDataM;
	    //W
	  wire regWriteW,memToRegW,jalOpW;
	  wire [31:0] loadDataW,aluOutW,pcW,resultW;
	  wire [4:0] writeRegW;
	    //hazard
	  wire forwardAD,forwardAEm,stall;
	  wire [1:0] forwardAE,forwardBE;
	  ////////////////////////////////////
	 //control
	 assign op = instrD[31:26];
	 assign func = instrD[5:0];
	 control control1(op,func,regWriteD,memToRegD,memWriteD,aluCtrD,aluSrcD,regDstD,branchD,extOpD,jalOpD,jrOpD,Tuse_rsD,Tuse_rtD,TnewD);
	 //F part
	  assign pcPlus4F = pcF + 4;//******************
	  npc npc1(pcPlus4F,pcBranchD,pcSrcD,jalOpD,pcJumpD,jrOpD,rd1D,npc);///////////////
	  pc pc1(npc,reset,clk,!stall,pcF);
	  IM im1(pcF,instrF);
	  //D part
	  IF_ID IF_ID1(instrF,pcF,clk,!stall,pcPlus4F,reset,instrD,pcD,pcPlus4D);
	  assign pcSrcD = (equalD === 1) & (branchD === 1);
	  assign equalD = (rd1D == rd2D);
	  assign rsD = instrD[25:21];
	  assign rtD = instrD[20:16];
	  assign rdD = instrD[15:11];
	  assign rd1D = (forwardAD) ? aluOutM : data1;//*******
	  assign rd2D = (forwardBD) ? aluOutM : data2;
	  GRF grf1(rsD,rtD,writeRegW,resultW,clk,reset,regWriteW,pcW,data1,data2);
	  ext ext1(imm,extOpD,imm32D);
	  assign pcJumpD = {pcD[31:28],instrD[25:0],2'b00};//**********
	  assign pcBranchD = {imm32D[29:0],2'b00} + pcPlus4D;//********
	  //E part
	  ID_IE ID_IE1(clk,regWriteD,memToRegD,memWriteD,aluCtrD,aluSrcD,regDstD,jalOpD,rd1D,rd2D,rsD,rtD,rdD,imm32D,pcD,
	  stall,TnewD,regWriteE,memToRegE,memWriteE,aluCtrE,aluSrcE,regDstE,jalOpE,rd1E,rd2E,rsE,rtE,rdE,imm32E,pcE,TnewE);
	  assign in1E = (forwardAE == 2'b10) ? aluOutM:
	                (forwardAE == 2'b01) ? resultW:rd1E;
	  assign rd2True = (forwardBE == 2'b10) ? aluOutM:
	                (forwardBE == 2'b01) ? resultW : rd2E;
	  assign in2E = (aluSrcE == 1) ? imm32E : rd2True;
	  ALU alu1(in1E,in2E,aluCtrE,aluOutE_0);
	  assign aluOutE = (jalOpE == 1) ? (pcE + 8) : aluOutE_0;
	  assign writeRegE = (jalOpE == 1) ? 31 :
	                     (regDstE == 1) ? rdE : rtE;
	 // M part
	    /////
	 wire [4:0] rtM;
	 wire [31:0] writeM;
	 wire forwardM;
	 assign forwardM = (rtM != 0)&(rtM == writeRegW)&(regWriteW);
	 assign writeM = (forwardM) ? resultW : writeDataM;
	    ////////
	 IE_IM IE_IM1(clk,regWriteE,memToRegE,memWriteE,jalOpE,aluOutE,rd2True,writeRegE,pcE,TnewE,rtE,regWriteM,memToRegM,memWriteM,jalOpM,aluOutM,writeDataM,writeRegM,pcM,TnewM,rtM);
	 DM DM1(clk,reset,aluOutM,writeM,memWriteM,pcM,loadDataM);
	 // W part
	 IM_IW IM_IW1(clk,regWriteM,memToRegM,jalOpM,loadDataM,aluOutM,pcM,writeRegM,regWriteW,memToRegW,jalOpW,loadDataW,aluOutW,pcW,writeRegW);
	 assign resultW =  (memToRegW == 1) ? loadDataW : aluOutW;
	   /*(jalOpW == 1) ? (pcW+8) :*/               
	 //hazard
	 hazard hazard1(rsD,rtD,rsE,rtE,writeRegE,memToRegE,regWriteE,writeRegM,regWriteM,memToRegM,writeRegW,regWriteW,Tuse_rsD,Tuse_rtD,TnewE,TnewM,stall,forwardAD,forwardBD,forwardAE,forwardBE);
endmodule
