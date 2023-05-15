`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:33:15 11/16/2022 
// Design Name: 
// Module Name:    IE_IM 
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
module IE_IM(
    input clk,
    input regWriteE,
    input memToRegE,
    input memWriteE,
    input jalOpE,
    input [31:0] aluOutE,
    input [31:0] rd2True,
    input [4:0] writeRegE,
    input [31:0] pcE,
	 input [1:0] TnewE,
	 input [4:0] rtE,
    output reg regWriteM,
    output reg memToRegM,
    output reg memWriteM,
    output reg jalOpM,
    output reg [31:0] aluOutM,
    output reg [31:0] writeDataM,
    output reg [4:0] writeRegM,
    output reg [31:0] pcM,
	 output reg [1:0] TnewM,
	 output reg [4:0] rtM
    );
    always@(posedge clk)begin
	    regWriteM <= regWriteE;
		 memToRegM <= memToRegE;
		 memWriteM <= memWriteE;
		 jalOpM <= jalOpE;
		 aluOutM <= aluOutE;
		 writeDataM <= rd2True;
		 writeRegM <=writeRegE;
		 pcM <= pcE;
		 rtM <= rtE;
		 if(TnewE == 0) TnewM <= 0;
		 else TnewM <= TnewE - 1;
	 end

endmodule
