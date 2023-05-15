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
    output [1:0] memWriteD,//
    output [3:0] aluCtrD,
    output aluSrcD ,
    output regDstD,
    output [1:0] branchD,
    output [2:0] extOpD ,
    output jalOpD,
    output jrOpD,
	 output [1:0] Tuse_rsD,
	 output [1:0] Tuse_rtD,
	 output [1:0] TnewD ,
	 output [2:0] hiloOpD,//
	 output [1:0] hiloWriteD,//
	 output [2:0] lOpD,//
	 output isHilo
    );
    wire r = (op == 0);
	 wire add = r & (func === 6'b100000);
	 wire sub = r & (func === 6'b100010);
	 wire and_ = r & (func === 6'b100100);
	 wire or_ = r & (func === 6'b100101);
	 wire slt = r & (func === 6'b101010);
	 wire sltu = r & (func === 6'b101011);
	 wire addi = (op === 6'b001000);//signed add imm
	 wire andi = (op === 6'b001100);
	 wire ori = (op === 6'b001101);
	 wire lui = (op === 6'b001111);
	 wire lb = (op === 6'b100000);
	 wire lh = (op === 6'b100001);
	 wire lw = (op === 6'b100011);
	 wire sb = (op === 6'b101000);
	 wire sh = (op === 6'b101001);
    wire sw = (op === 6'b101011);
	 wire beq = (op === 6'b000100);
	 wire bne = (op === 6'b000101);
	 wire jal = (op === 6'b000011);
	 wire jr = r & (func === 6'b001000);
	 wire mult = r & (func === 6'b011000);
	 wire multu = r & (func === 6'b011001);
	 wire div = r & (func === 6'b011010);
	 wire divu = r & (func === 6'b011011);
	 wire mfhi = r & (func === 6'b010000);
	 wire mflo = r & (func === 6'b010010);
	 wire mthi = r & (func === 6'b010001);
	 wire mtlo = r & (func === 6'b010011);
	 
	 wire classCal = add|sub|and_|or_|slt|sltu;
	 wire classL = lb|lh|lw;
	 wire classS = sb|sh|sw;
	 wire classHilo = mult|multu|div|divu|mthi|mtlo;
	 
	 assign isHilo = mult|multu|div|divu|mfhi|mflo|mthi|mtlo;
	 assign regWriteD = (add|sub|and_|or_|slt|sltu|addi|andi|ori|lui|lb|lh|lw|jal|mfhi|mflo) ? 1'b1 : 1'b0;
	 assign memToRegD = (classL) ? 1'b1 : 1'b0;
	 assign aluCtrD = (sub) ? 4'b0001://no beq
	                  (ori|or_) ? 4'b0010 :
							(and_|andi) ? 4'b0011 :
							(slt) ? 4'b0100 :
							(sltu) ? 4'b0101 :
							4'b0000;
    assign aluSrcD = (addi|andi|ori|classL|classS|lui) ? 1'b1 : 1'b0;
	 assign regDstD = (classCal|mfhi|mflo) ? 1'b1 : 1'b0;
    assign branchD = (beq) ? 2'b01 :
                     (bne) ? 2'b10 : 
							2'b00;
    assign extOpD = (addi|classL|classS|beq|bne) ? 3'b001:
                    (lui) ? 3'b010:
                    3'b000;
    assign jalOpD = jal;
    assign jrOpD = jr;	 
	 assign Tuse_rsD = (jr|beq|bne) ? 0 :
	                   (classCal|addi|andi|ori|classL|classS|classHilo) ? 1 :
							 3;
	 assign Tuse_rtD = (beq|bne) ? 0 :
	                   (classCal|classHilo) ? 1 :
							 (classS) ? 2 :
							 3;
	assign TnewD = (classL) ? 3 :
	               (classCal|addi|andi|ori|lui|jal|mfhi|mflo) ? 2 :
						0;
	assign hiloOpD = (mult) ? 3'b001 :
	                 (multu) ? 3'b010 :
						  (div) ? 3'b011 :
						  (divu) ? 3'b100 :
						  (mthi) ? 3'b101 :
						  (mtlo) ? 3'b110 :
						  3'b000;
	assign hiloWriteD = (mfhi) ? 2'b10 :
	                    (mflo) ? 2'b01 :
							  2'b00;
	assign memWriteD = (sw) ? 2'b11 :
	                   (sb) ? 2'b01 :
							 (sh) ? 2'b10 : 
                      2'b00;
	assign lOpD = (lb) ? 3'b010 :
	              (lh) ? 3'b100 :
					  3'b000;
endmodule
