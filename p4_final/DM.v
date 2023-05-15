`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:16:31 11/05/2022 
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
    input memwrite,
    input [31:0] address,//aluout
    input [31:0] pc,
    input [31:0] writedata,//read2
    output [31:0] out
    );
	 reg[31:0] dm [0:1023];
	 wire [9:0] addr;
	 
	 assign addr = address [11:2];
	 assign out = dm[addr];
	 
    integer i;
	 initial begin
	    for(i=0;i<=1023;i=i+1) dm[i]=0;
	 end
    always@(posedge clk)begin
	    if(reset)begin
		 for(i=0;i<=1023;i=i+1) dm[i]=0;
		 end
		 else if(memwrite)begin
		    dm[addr] = writedata;
			 $display("@%h: *%h <= %h",pc,address,writedata);
		 end
	 end
endmodule
