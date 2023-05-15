`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:15:03 11/16/2022 
// Design Name: 
// Module Name:    IM_IW 
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
module IM_IW(
    input clk,
    input regWriteM,
    input memToRegM,
    input jalOpM,
    input [31:0] loadDataM,
    input [31:0] aluOutM,
    input [31:0] pcM,
    input [4:0] writeRegM,
    output reg regWriteW ,
    output reg memToRegW ,
    output reg jalOpW ,
    output reg [31:0] loadDataW ,
    output reg [31:0] aluOutW ,
    output reg [31:0] pcW ,
    output reg [4:0] writeRegW 
    );
	 always@(posedge clk)begin
	    regWriteW <= regWriteM;
		 memToRegW <= memToRegM;
		 jalOpW <= jalOpM;
		 loadDataW <= loadDataM;
		 aluOutW <= aluOutM;
		 pcW <= pcM;
		 writeRegW <= writeRegM;
	 end


endmodule
