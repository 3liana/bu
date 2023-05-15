`timescale      1ns/1ns
`include "head.v"
module EXT(
input [15:0] imm16,
input [1:0] EXTCtrl,
output [31:0] E32_D
);
wire [31:0] zero_ext,signed_ext,lui_ext,b_ext;
assign zero_ext = {16'b0,imm16};
assign signed_ext = {{16{imm16[15]}},imm16};
assign lui_ext = {imm16,16'b0};
assign b_ext = {{14{imm16[15]}},imm16,2'b0};

assign E32_D = (EXTCtrl == `EXT_SIGN) ? signed_ext:
				 (EXTCtrl == `EXT_LUI) ? lui_ext:
				 (EXTCtrl == `EXT_B) ? b_ext:
				                   zero_ext;
endmodule