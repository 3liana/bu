`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:38:00 11/16/2022 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
    input reset,
    input [31:0] aluOutM,
    input [31:0] writeDataM,
    input memWriteM,
	 input [31:0] pcM,
    output [31:0] loadDataM
    );
	 reg [31:0] dm [0:3071];
	 wire [11:0]addr = aluOutM[13:2];
	 assign loadDataM = dm[addr];
	 integer i;
	 initial begin
	    for(i=0;i<3072;i=i+1) dm[i] = 32'h0;
	 end
	 always@(posedge clk)begin
	    if(reset)begin
		    for(i=0;i<3072;i=i+1) dm[i] = 32'h0;
		 end
		 else if(memWriteM)begin
		    dm[addr] = writeDataM;
			 $display("%d@%h: *%h <= %h", $time, pcM, aluOutM, writeDataM);
		 end
	 end


endmodule
