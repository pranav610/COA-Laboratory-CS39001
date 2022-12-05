`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:29:36 10/21/2022 
// Design Name: 
// Module Name:    mux_32_2_to_1 
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
// 2x1 Multiplexer with 32 bit inputs and output
module mux_32_2_to_1(
	input [31:0] a0,
	input [31:0] a1,
	input sel,
	output [31:0] out
    );
	assign out = (sel)? a1 : a0;
endmodule
