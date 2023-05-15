`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:10 11/05/2022 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] input1,
    input [31:0] input2,
    input [2:0] ctr,
    output reg [31:0] out,
    output iszero
    );
	 assign iszero = (out==0);
    always@(*)begin
	    case(ctr)
		    3'b000:out = input1+input2;
			 3'b001:out = input1-input2;
			 3'b010:out = input1|input2;
		 endcase
	 end

endmodule
