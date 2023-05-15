`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:25:48 11/05/2022 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] pc,
    input [31:0] imm,//extout
    input branch,
    input iszero,
    input jump,
	 input jumpreg,
    input [31:0] read1,
	 input [25:0] ins25,
    output reg [31:0] out
    );
    reg [31:0] p4;
	 reg [31:0] pimm;
	 reg [31:0] ishift;
	 reg [31:0] pj;
	 //reg [31:0] preg;
	// reg [31:0] out0;
	 //wire beq;
	 //assign beq = branch && iszero;wrong and why????
	 always@(*)begin
	    ishift = {imm[29:0],2'b00};
	    p4 = pc + 4;
		 pimm = p4 + ishift;//b type pc+4+imm
		 pj = {p4[31:28],ins25,2'b00};//j type composed of ins25
       if(jumpreg == 1) out = read1;//jump reg rs
       else if(jump == 1) out = pj;
       else if(branch == 1 && iszero == 1)  out = pimm;
       else out = p4;		 
	 end

endmodule
