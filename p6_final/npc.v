`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:52:19 11/16/2022 
// Design Name: 
// Module Name:    npc 
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
module npc(
    input [31:0] pcPlus4F,
    input [31:0] pcBranchD,
    input pcSrcD,
    input jalOp,
    input [31:0] pcJumpD,
    input jrOp,
    input [31:0] rd1D,
    output  [31:0] npc
    );
    assign npc = (jrOp == 1) ? rd1D :
	              (jalOp == 1) ? pcJumpD :
					  (pcSrcD == 1) ? pcBranchD : 
					  pcPlus4F;
endmodule
