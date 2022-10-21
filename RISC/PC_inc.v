`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:53:18 10/20/2022 
// Design Name: 
// Module Name:    PC_inc 
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
module PC_inc(
	input [31:0] instruction,
	output [31:0]	new
    );
	assign new = instruction + 32'b00000000000000000000000000000100;
endmodule
