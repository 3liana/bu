`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:47:24 11/05/2022 
// Design Name: 
// Module Name:    PC 
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
module PC(
     input[31:0] nextPC,
	  input clk,
	  input reset,
	  output reg[31:0] pc
    );
	 initial begin
	    pc=32'h00003000;
	 end
	 
	 always@(posedge clk)begin
	    if(reset)begin//同步复位
		    pc <= 32'h00003000;
		 end
		 else begin
		    pc <= nextPC;
		 end
	 end


endmodule
