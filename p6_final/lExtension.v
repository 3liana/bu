`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:44:14 12/01/2022 
// Design Name: 
// Module Name:    lExtension 
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
module lExtension(
    input [1:0] ad2,
    input [31:0] dataIn,
    input [2:0] loadOp,
    output reg [31:0] dataOut
    );
    always@(*)begin
	    case(loadOp)
		    3'b000: dataOut = dataIn;//lw
			 3'b001:begin//unsigned lb
			    if(ad2 == 2'b00) dataOut = {{24{1'b0}},dataIn[7:0]};
				 else if(ad2 == 2'b01) dataOut = {{24{1'b0}},dataIn[15:8]};
				 else if(ad2 == 2'b10) dataOut = {{24{1'b0}},dataIn[23:16]};
				 else if(ad2 == 2'b11) dataOut = {{24{1'b0}},dataIn[31:24]};
			 end
			 3'b010:begin//signed lb
			    if(ad2 == 2'b00) dataOut = {{24{dataIn[7]}},dataIn[7:0]};
				 else if(ad2 == 2'b01) dataOut = {{24{dataIn[15]}},dataIn[15:8]};
				 else if(ad2 == 2'b10) dataOut = {{24{dataIn[23]}},dataIn[23:16]};
				 else if(ad2 == 2'b11) dataOut = {{24{dataIn[31]}},dataIn[31:24]};
			 end
			 3'b011:begin//unsigned lh
			    if(ad2[1] == 0) dataOut = {{16{1'b0}},dataIn[15:0]};
				 else if(ad2[1] == 1) dataOut = {{16{1'b0}},dataIn[31:16]};
			 end
			 3'b100:begin//signed lh
			    if(ad2[1] == 0) dataOut = {{16{dataIn[15]}},dataIn[15:0]};
				 else if(ad2[1] == 1) dataOut = {{16{dataIn[31]}},dataIn[31:16]};
			 end
		 endcase
	 end

endmodule
