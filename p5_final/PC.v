`timescale      1ns/1ns
module PC(
input clk,
input reset,
input stop,
input [31:0] nPC_F,
output reg [31:0] PC_F
);

initial PC_F = 32'h0000_3000;

always@(posedge clk) begin
	if(reset == 1) begin
		PC_F <= 32'h0000_3000;
	end
	else begin
		if(stop == 1) PC_F <= PC_F;
		else PC_F <= nPC_F;
	end
end

endmodule