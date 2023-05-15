`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:25:22 11/16/2022 
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
    input [31:0] in1E,
    input [31:0] in2E,
    input [3:0] aluCtrE,
    output reg [31:0] aluOutE
    );
	 always@(*)begin
	    case(aluCtrE)
		    3'b000: aluOutE = in1E + in2E;
			 3'b001: aluOutE = in1E - in2E;
			 3'b010: aluOutE = in1E | in2E;
		 endcase
	 end


endmodule
