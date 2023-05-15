`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:02:30 11/16/2022 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [15:0] imm,
    input [2:0] extOp,
    output reg [31:0] imm32D
    );
    always@(*)begin
	    case(extOp)
          3'b000:imm32D = 	{{16{1'b0}},imm};
          3'b001:imm32D = {{16{imm[15]}},imm};
          3'b010:imm32D = {imm,16'h0};			 
		 endcase
	 end

endmodule
