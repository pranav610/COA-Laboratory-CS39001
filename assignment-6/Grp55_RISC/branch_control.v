`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:54:15 10/21/2022 
// Design Name: 
// Module Name:    branch_control 
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
module branch_control(opCode, flagZero, flagSign, flagCarry, out);  
	 input [5:0] opCode;
	 input flagZero, flagSign, flagCarry;
	 output out;
	 
	 wire b, bZero, bNZero, bSign, bCarry, bNCarry;
	 
	 assign b = (opCode == 6'b101011) |(opCode == 6'b101000) | (opCode == 6'b100000); 
	 assign bZero = (opCode == 6'b110001) & flagZero;
	 assign bNZero = (opCode == 6'b110010) & ~flagZero;
	 assign bSign = (opCode == 6'b110000) & flagSign;
	 assign bCarry = (opCode == 6'b101001) & flagCarry;
	 assign bNCarry = (opCode == 6'b101010) & ~flagCarry;
	 
	 assign out = b | bZero | bNZero | bSign | bCarry | bNCarry;	
endmodule 