`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:21:04 11/09/2022 
// Design Name: 
// Module Name:    demo_wrapper 
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
module demo_wrapper(clk100mhz, rst,  sel, inp, out);
	input clk100mhz, rst, sel;
	input [9:0] inp;
	output [15:0] out;
	
	processor CPU1(.clk(clk100mhz), .rst(rst), .sel(sel), .inp(inp), .out(out));
	


endmodule
