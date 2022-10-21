`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:09 10/21/2022 
// Design Name: 
// Module Name:    mux_5_3_to_1 
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
// 3x1 Multiplexer with 5 bit inputs and outputs
module mux_5_3_to_1(
	input [4:0] inp1,
	input [4:0] inp2,
	input [4:0] inp3,
	input [1:0] sel,
	output [4:0] out
    );
	 
	always @(*)
	begin
		if (sel == 2'b00) out = inp1;
		else if (sel == 2'b01) out = inp2;
		else out = inp3;
	end
endmodule
