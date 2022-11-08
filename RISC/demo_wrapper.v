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
module demo_wrapper(clk, rst, RAMSel, button, out);
	input clk, rst, RAMSel, button;
	output [15:0] out;
	
	processor CPU1(.clk(clk), .rst(rst), .RAMSel(RAMSel), .button(button), .out(out));
	


endmodule
