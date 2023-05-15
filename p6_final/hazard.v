`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:23:22 11/16/2022 
// Design Name: 
// Module Name:    hazard 
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
module hazard(
    input [4:0] rsD,
    input [4:0] rtD,
	 
    input [4:0] rsE,
    input [4:0] rtE,
    input [4:0]writeRegE,
    input memToRegE,
	 input regWriteE,
	 
	 input [4:0] writeRegM,
    input regWriteM,
	 input memToRegM,
	 
    input [4:0] writeRegW,
    input regWriteW,
	 
    input [1:0] Tuse_rsD,
    input [1:0] Tuse_rtD,
    input [1:0] TnewE,
    input [1:0] TnewM,
    	 
    output reg stall = 0,
    output reg forwardAD = 0,
    output reg forwardBD = 0,
    output reg [1:0] forwardAE = 0,
    output reg [1:0] forwardBE = 0
    );
	 reg lwstall = 0;
	 reg branchstall = 0;
	 initial begin
      stall = 0;
      forwardAD = 0;
      forwardBD = 0;
      forwardAE = 0;
      forwardBE = 0;
	end
	 always@(*)begin
	    ////////forward
	    if((rsE != 0)&&(rsE == writeRegM)&&(regWriteM)&&(TnewM == 0)) forwardAE = 2'b10;//foward m first
		 else if ((rsE != 0)&&(rsE == writeRegW)&&(regWriteW)) forwardAE = 2'b01;
		 else forwardAE = 0;
		 
		 if((rtE != 0)&&(rtE == writeRegM)&&(regWriteM)&&(TnewM == 0)) forwardBE = 2'b10;
		 else if ((rtE != 0)&&(rtE == writeRegW)&&(regWriteW)) forwardBE = 2'b01;
		 else forwardBE = 0;
		 
		 forwardAD = (rsD != 0)&&(rsD == writeRegM)&&(regWriteM)&&(TnewM == 0);
		 forwardBD = (rtD != 0)&&(rtD == writeRegM)&&(regWriteM)&&(TnewM == 0);
		 /////////////////////////////
		 stall = 0;
       if((rsD != 0)&&(rsD == writeRegE)&&(regWriteE === 1)&&(Tuse_rsD < TnewE)) stall = 1;
		 else if((rsD != 0)&&(rsD == writeRegM)&&(regWriteM === 1)&&(Tuse_rsD < TnewM))stall = 1;
       if((rtD != 0)&&(rtD == writeRegE)&&(regWriteE === 1)&&(Tuse_rtD < TnewE)) stall = 1;
       else if((rtD != 0)&&(rtD == writeRegM)&&(regWriteM === 1)&&(Tuse_rtD < TnewM))stall = 1; 
	 end


endmodule
