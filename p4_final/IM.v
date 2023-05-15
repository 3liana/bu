`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:50:05 11/05/2022 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [31:0] address,
    output [25:0] ins25,
    output [5:0] op,
    output [5:0] func,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [15:0] imm
    );
	 reg [31:0] im[0:1023];//rom
	 wire [9:0] addr;
	 wire [31:0] content;
	 
	 assign addr[9:0] = address [11:2];
	 
	 initial begin
	   $readmemh("code.txt",im);
	 end
	 
	 assign content = im[addr];
    assign ins25 = content[25:0];
	 assign op = content[31:26];
	 assign func = content[5:0];
	 assign rs = content[25:21];
	 assign rt = content[20:16];
	 assign rd = content[15:11];
	 assign imm = content[15:0];

endmodule
