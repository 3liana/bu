`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:21:29 11/16/2022 
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
    input [5:0] op,
    input [5:0] func,
    output regWriteD,
    output memToRegD,
    output memWriteD,
    output [3:0] aluCtrD,
    output aluSrcD ,
    output regDstD,
    output branchD,
    output [2:0] extOpD ,
    output jalOpD,
    output jrOpD,
	 output [1:0] Tuse_rsD,
	 output [1:0] Tuse_rtD,
	 output [1:0] TnewD 
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
	 
	 assign regWriteD = (add|sub|ori|lw|lui|jal) ? 1'b1 : 1'b0;
	 assign memToRegD = (lw) ? 1'b1 : 1'b0;
	 assign memWriteD = (sw) ? 1'b1 : 1'b0;
	 assign aluCtrD = (sub|beq) ? 4'b0001:
	                  (ori) ? 4'b0010:
							4'b0000;
    assign aluSrcD = (ori|lw|sw|lui) ? 1'b1 : 1'b0;
	 assign regDstD = (add|sub) ? 1'b1 : 1'b0;
    assign branchD = (beq) ? 1'b1 : 1'b0;
    assign extOpD = (lw|sw|beq) ? 3'b001:
                    (lui) ? 3'b010:
                    3'b000;
    assign jalOpD = jal;
    assign jrOpD = jr;	 
	 assign Tuse_rsD = (jr|beq) ? 0 :
	                   (add|sub|ori|lw|sw) ? 1 :
							 3;
	 assign Tuse_rtD = (beq) ? 0 :
	                   (add|sub) ? 1 :
							 (sw) ? 2 :
							 3;
	assign TnewD = (lw) ? 3 :
	               (add|sub|ori|lui|jal) ? 2 :
						0;
	
endmodule
