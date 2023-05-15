`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:15:16 11/16/2022 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
    input [31:0] instrF,
    input [31:0] pcF,
	 input clk,
    input en,
    input [31:0] pcPlus4F,
	 input reset,
    output reg [31:0] instrD,
    output reg [31:0] pcD ,
    output reg [31:0] pcPlus4D
    );
	 always@(posedge clk)begin
	    if(reset)begin
		    instrD = 0;
			 pcD = 0;
			 pcPlus4D = 0;
		 end
		 else begin
	       if(en)begin
		       instrD <= instrF;
			    pcD <= pcF;
			    pcPlus4D <= pcPlus4F;
		    end
		    else begin
		       instrD <= instrD;
			    pcD <= pcD;
		   	 pcPlus4D <= pcPlus4D;
		    end
		end
	 end


endmodule
