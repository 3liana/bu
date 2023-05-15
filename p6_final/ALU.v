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
		    4'b0000: aluOutE = in1E + in2E;
			 4'b0001: aluOutE = in1E - in2E;
			 4'b0010: aluOutE = in1E | in2E;
			 4'b0011: aluOutE = in1E & in2E;
			 4'b0100: aluOutE = ($signed(in1E) < $signed(in2E)) ? {{31{1'b0}},1'b1} : {32{1'b0}};
			 4'b0101: aluOutE = (in1E < in2E) ? 1 : 0;
		 endcase
	 end


endmodule
