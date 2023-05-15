`timescale 1ns / 1ps
`include "head.v"
module decoder(
    input [5:0] op,
    input [5:0] func,
    output reg addu,
    output reg subu,
    output reg ori,
    output reg lui,
    output reg lw,
    output reg sw,
    output reg beq,
    output reg j,
    output reg jal,
    output reg jr,
    output reg jalr,
    output reg bgtz,
    output reg lb,
    output reg sb,
    output reg sh,
    output reg lh,
    output reg bgezalr,
    output reg clz
    );

initial begin
	  addu = 0;
    subu = 0;
    ori = 0;
    lui = 0;
    lw = 0;
    sw = 0;
    beq = 0;
    j = 0;
    jal = 0;
    jr = 0;
    jalr = 0;
    bgtz = 0;
    lb = 0;
    sb = 0;
    sh = 0;
    lh = 0;
    bgezalr = 0;
    clz = 0;
end

	//identify the instruction
always@(*)begin
	addu = (op == `RTYPE) && (func == `R_ADDU);
	subu = (op == `RTYPE) && (func == `R_SUBU);
	sw = (op == `SW);
  lw = (op == `LW);
  ori = (op == `ORI);
  beq = (op == `BEQ);
  lui = (op == `LUI);
  j = (op == `J);
  jal = (op == `JAL);
  jr = (op == `RTYPE) && (func == `R_JR);
  jalr = (op == `RTYPE) && (func == `R_JALR );
  bgtz = (op == `BGTZ);
  lb = (op == `LB);
  sb = (op == `SB);    
  sh = (op == `SH);
  lh = (op == `LH);
  bgezalr = (op == `RONE) && (func == `BGEZALR); 
  clz = (op == `R_SPECIAL2) && (func == `CLZ);
end
	//nop?
endmodule