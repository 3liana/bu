`timescale 1ns/1ns
`include "head.v"    
module IM(PC_addr,Instr_F);
input [31:0] PC_addr;
output [31:0] Instr_F;
reg [31:0] Instr_memory [0:`Rom_size];
integer i;
initial begin
	for(i=0;i<1024;i=i+1) begin
		Instr_memory[i] = 32'h0;
	end
end
initial
$readmemh ("code.txt",Instr_memory);
wire [9:0] addr = PC_addr[11:2];
assign Instr_F = Instr_memory[addr];
endmodule