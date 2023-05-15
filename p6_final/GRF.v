`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:50:05 11/16/2022 
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
    input [4:0] rsD,
    input [4:0] rtD,
    input [4:0] writeRegW,
    input [31:0] resultW,
    input clk,
    input reset,
    input regWriteW,
	 input [31:0] pcW,
    output reg [31:0] data1,
    output reg [31:0] data2
    );
	 reg [31:0] regs [0:31];
	 integer i;
    initial begin
	    for(i=0;i<32;i=i+1)begin
		    regs[i] = 32'h0;
		 end
	 end
	 always@(*)begin
	    if(regWriteW === 1 && writeRegW == rsD && rsD != 0) data1 = resultW;
		 else data1 = regs[rsD];
		 if(regWriteW === 1 && writeRegW == rtD && rtD != 0) data2 = resultW;
		 else data2 = regs[rtD];
	 end
   // assign data1 = regs[rsD];
	 //assign data2 = regs[rtD];
	 always@(posedge clk)begin
	    if(reset)begin
		    for(i=0;i<32;i=i+1)begin
			    regs[i] <= 32'h0;
			 end
		 end
		 else if(regWriteW && (writeRegW != 0)) begin
		    regs[writeRegW] <= resultW;
			// $display("%d@%h: $%d <= %h", $time, pcW, writeRegW, resultW);
		 end
	 end
endmodule
