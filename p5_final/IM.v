`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:03:21 11/16/2022 
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
    input [31:0] pcF,
    output [31:0] instrF
    );
	 reg [31:0] im[0:4095];//rom
	 wire [11:0] addr;
	 integer i;
	 wire [31:0] pcminus;
	 assign pcminus = pcF - 32'h00003000;
	 assign addr[11:0] = pcminus[13:2];
	 initial begin
	    for(i=0;i<4096;i=i+1)begin
		    im[i] = 32'h0;
		 end
	    $readmemh("code.txt",im);
	 end
    assign instrF = im[addr];

endmodule
