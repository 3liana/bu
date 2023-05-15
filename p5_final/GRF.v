`timescale 1ns/1ns
`include "head.v"
module GRF(
	input clk,
	input reset,
	input RegWr_W,
	input [4:0] A1_D,
	input [4:0] A2_D,
	input [4:0] A3_W,
	input [31:0] WD_W,
	input [31:0] PC_W,
	output [31:0] RD1_D,
	output [31:0] RD2_D
);

reg [31:0] registers [0:31];
integer i;
assign RD1_D = registers[A1_D];
assign RD2_D = registers[A2_D];
initial begin
	for(i=0;i<32;i=i+1) begin
			case(i)
			28: registers[i] <= 32'h0000_1800;
			29: registers[i] <= 32'h0000_2ffc;
			default: registers[i] <= 32'b0;
			endcase
		end
end
always@(posedge clk) begin
	if(reset == 1) begin
		for(i=0;i<32;i=i+1) begin
			case(i)
			28: registers[i] <= 32'h0000_1800;
			29: registers[i] <= 32'h0000_2ffc;
			default: registers[i] <= 32'b0;
			endcase
		end
	end
	else begin
		if(A3_W == 5'b0) begin
			registers[A3_W] <= 32'b0;
		end
		else if(RegWr_W==1) begin
			registers[A3_W] <= WD_W;
			$display("%d@%h: $%d <= %h", $time, PC_W, A3_W, WD_W);
		end
	end
end

endmodule