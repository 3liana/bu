`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:17:03 11/16/2022 
// Design Name: 
// Module Name:    ID_IE 
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
module ID_IE(
    input clk,
    input regWriteD,
    input memToRegD,
    input memWriteD,
    input [3:0] aluCtrD,
    input aluSrcD,
    input regDstD,
    input jalOpD,
    input [31:0] rd1D,
    input [31:0] rd2D,
    input [4:0] rsD,
    input [4:0] rtD,
    input [4:0] rdD,
    input [31:0] imm32D,
    input [31:0] pcD,
    input clr,
	 input [1:0] TnewD,
    output reg regWriteE,
    output reg memToRegE,
    output reg memWriteE,
    output reg [3:0] aluCtrE,
    output reg aluSrcE,
    output reg regDstE,
    output reg jalOpE,
    output reg [31:0] rd1E,
    output reg [31:0] rd2E,
    output reg [4:0] rsE,
    output reg [4:0] rtE,
    output reg [4:0] rdE,
    output reg [31:0] imm32E,
    output reg [31:0] pcE,
    output reg [1:0] TnewE	 
    );
    always@(posedge clk)begin
	    if(clr)begin
		    rsE <= 0;
			 rtE <= 0;
			 rdE <= 0;
			 memWriteE <= 0;
			 regWriteE <= 0;
		 end
		 else begin
		    regWriteE <= regWriteD;
			 memToRegE <= memToRegD;
			 memWriteE <= memWriteD;
			 aluCtrE <= aluCtrD;
			 aluSrcE <= aluSrcD;
			 regDstE <= regDstD;
			 jalOpE <= jalOpD;
			 rd1E <= rd1D;
			 rd2E <= rd2D;
			 rsE <= rsD;
			 rtE <= rtD;
			 rdE <= rdD;
			 imm32E <= imm32D;
			 pcE <= pcD;
			 if(TnewD == 0) TnewE <= 0;
			 else TnewE <= TnewD - 1;
		 end
	 end

endmodule
