`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module MUX_4to1_32b(
	input [31:0] a0,
	input [31:0] a1,
	input [31:0] a2,
	input [31:0] a3,
	input [1:0] Ctrl,
	output [31:0] out
);
	assign out = (Ctrl == 2'b01) ? a1:
				 (Ctrl == 2'b10) ? a2:
				 (Ctrl == 2'b11) ? a3:
				 				   a0;
endmodule

//ALU_Src
module MUX_2to1_32b(
input [31:0] a0,
input [31:0] a1,
input Ctrl,
output [31:0] out
);

assign out = (Ctrl) ? a1: a0;
endmodule


module MUX_3to1_32b(
	input [31:0] a0,
	input [31:0] a1,
	input [31:0] a2,
	input [1:0] Ctrl,
	output [31:0] out
);
	assign out = (Ctrl == 2'b01) ? a1:
				 (Ctrl == 2'b10) ? a2:
				 				   a0;
endmodule

module MUX_3to1_5b(
	input [4:0] a0,
	input [4:0] a1,
	input [4:0] a2,
	input [1:0] Ctrl,
	output [4:0] out
);
	assign out = (Ctrl == 2'b01) ? a1:
				 (Ctrl == 2'b10) ? a2:
				 				   a0;
endmodule
		               