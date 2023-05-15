`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:02:52 11/05/2022 
// Design Name: 
// Module Name:    control 
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
module control(
    input [5:0] func,
    input [5:0] op,
    output reg [1:0] regdst=0,
    output reg alusrc=0,
    output reg [1:0] memtoreg=0,
    output reg regwrite=0,
    output reg  memwrite=0,
    output reg branch=0,
    output reg [1:0] extop=0,
    output reg [2:0] aluctr=0,
    output reg j=0,
    output reg jumpreg=0
    );
	 wire r = (op == 0);
	 wire add = r & (func === 6'b100000);
	 wire sub = r & (func === 6'b100010);
	 wire ori = (op === 6'b001101);
	 wire lw = (op === 6'b100011);
    wire sw = (op === 6'b101011);
	 wire beq = (op === 6'b000100);
	 wire lui = (op === 6'b001111);
	 wire jal = (op === 6'b000011);
	 wire jr = r & (func === 6'b001000);
	 
    always@(*)begin
	    regdst = (add|sub) ? 2'b01 :
		          (jal) ? 2'b10 :
					 2'b00;
		 alusrc = (ori|lw|sw|lui) ? 1 : 0;
		 memtoreg = (lw) ? 2'b01:
		            (jal) ? 2'b10:
						2'b00;
		regwrite = (add|sub|ori|lw|lui|jal|jr) ? 1 : 0;
      memwrite = sw;
      branch = beq;
      extop = (lw|sw|beq) ? 2'b01 :
              (lui) ? 2'b10 :
              2'b00;				
     aluctr = (sub|beq) ? 3'b001:
              (ori) ? 3'b010:
              3'b000;
     j = jal;
     jumpreg = jr;	  
	 end

endmodule
