`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:53:44 11/05/2022 
// Design Name: 
// Module Name:    muxs 
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
module regmux(
   input [4:0] rt,
	input [4:0] rd,
	input [1:0] op,
	output reg [4:0] out
    );
	 always@(*)begin
	   case(op)
		   2'b00: out = rt;
			2'b01: out = rd;
			2'b10: out = 31;
		endcase
	end
endmodule

module alumux1(
   input [31:0] read2,
	input [31:0] imm,
	input op,
	output reg [31:0] out
    );
	 always@(*)begin
	   case(op)
		   0: out = read2;
			1: out = imm;
		endcase
	end

endmodule

module memmux(
   input [31:0] aluout,
	input [31:0] memout,
	input [31:0] addr,//p4
	input [1:0] op,
	output reg [31:0] out
    );
   always@(*)begin
	   case(op)
		   2'b00: out = aluout;
			2'b01: out = memout;
			2'b10: out = addr;
		endcase
	end

endmodule