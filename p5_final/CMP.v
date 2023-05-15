`timescale      1ns/1ns
`include "head.v"
module CMP(
input [31:0] V1_D,
input [31:0] V2_D,
input [2:0] CMPctr,
output judge
);

wire judge0 = (V1_D==V2_D);
wire judge1 = (V1_D[31] == 0);
wire judge2 = (V1_D >= V2_D);
wire judge3 = (V1_D < V2_D);
wire judge = (V1_D <= V2_D);


assign judge =  (CMPctr == 3'b001) ? judge1:
                                    judge0;

endmodule