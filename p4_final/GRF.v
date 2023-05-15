`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:53:28 11/05/2022 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input clk,
    input reset,
	 input regwrite,
    input [4:0] readreg1,
    input [4:0] readreg2,
    input [4:0] writereg,
    input [31:0] writedata, 
    input [31:0]pc,
    output [31:0] read1,
    output [31:0] read2
    );
    reg [31:0] regs [0:31];
	 assign read1 = regs[readreg1];
	 assign read2 = regs[readreg2];
	 integer i;
	 initial begin
	    for(i=0;i<=31;i=i+1)begin
		 regs[i] = 0;
		 end
	 end
	 always@(posedge clk)begin
	    if(reset)begin
		    for(i=0;i<=31;i=i+1)begin
		    regs[i] = 0;
			 end
		 end
		 else if(regwrite && writereg!=0)begin
		    regs[writereg] <= writedata;
			 $display("@%h: $%d <= %h", pc, writereg, writedata);
		 end
	 end

endmodule