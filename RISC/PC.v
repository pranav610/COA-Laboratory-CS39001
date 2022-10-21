`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:58:20 10/20/2022 
// Design Name: 
// Module Name:    PC 
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
// module for program counter
module PC(
	input [31:0] nextInstrAddr,
	input clk,
	input rst,
	output reg [31:0] instrAddr
    );
	
	always @(posedge clk or posedge rst) 
	begin
		if (rst) instrAddr <= -32'd4;
		else instrAddr <= nextInstrAddr;
	end
endmodule
