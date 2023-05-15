`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:32:31 12/01/2022 
// Design Name: 
// Module Name:    mulAndDiv 
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
`include "constants.v"
module mulAndDiv(
    input clk,
	 input reset,
	 input [2:0] op,
    input [31:0] d1,
    input [31:0] d2,
    output [31:0] lo,
    output [31:0] hi,
	 output reg busy,
	 output start
    );
	 ///
	 reg [4:0] circle = 0;
	 reg [63:0] result = 0;
	 ///regs and connected ouputs
    reg [31:0] regHi= 0;
	 reg [31:0] regLo = 0;
	 assign hi = regHi;
	 assign lo = regLo;
	 ///
	 assign start  =  (reset) ? 0 :
                  	(op === `hilo_mult)|(op === `hilo_multu)|(op === `hilo_div)|(op === `hilo_divu);
	 ////
	 always@(posedge clk)begin
	    if(reset)begin
		    regHi <= 0;
			 regLo <= 0;
			 busy <= 0;
		 end
		 else begin
		    if(circle == 0) begin
			    if(op === `hilo_mult)begin//mult
				    busy <= 1;
					 circle <= 5;
					 result <= $signed(d1) * $signed(d2);
				 end
				 else if(op === `hilo_multu)begin//multu
				    busy <= 1;
					 circle <= 5;
					 result <= d1*d2;
				 end
				 else if(op === `hilo_div)begin//div
				    busy <= 1;
					 circle <= 10;
					 result[31:0] <= $signed(d1) / $signed(d2);
					 result[63:32] <= $signed(d1) % $signed(d2);
				 end
				 else  if(op === `hilo_divu)begin//divu
				    busy <= 1;
					 circle <= 10;
					 result[31:0] <= d1 / d2;
					 result[63:32] <= d1 % d2;
				 end
             else  if(op === `hilo_mthi)begin//mthi
                regHi <= d1;
					 //$display("mthi 1.%h,2.%h", regHi,regLo);
				 end
             else  if(op === `hilo_mtlo)begin//mtlo
                regLo <= d1;
					// $display("mtho 1.%h,2.%h", regHi,regLo);
				 end
			 end
			 else if(circle == 1)begin
			    busy <= 0;
				 circle <= 0;
				 regHi <= result[63:32];
				 regLo <= result[31:0];
				 //$display("divmult1.%h,2.%h", regHi,regLo);
			 end
			 else begin
			    circle <= circle - 1;
			 end
		 end
	 end
endmodule
