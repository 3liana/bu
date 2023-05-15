`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:44:10 11/16/2022 
// Design Name: 
// Module Name:    pc 
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
module pc(
    input [31:0] npc,
	 input reset,
    input clk,
    input en,
    output reg [31:0] pcF
    );
	 initial begin
	     pcF = 32'h00003000;
	 end
	 always@(posedge clk)begin
	    if(reset) pcF <= 32'h00003000;
		 else begin
		    if(en) pcF <= npc;
			 else pcF <= pcF;
		 end
	 end


endmodule
