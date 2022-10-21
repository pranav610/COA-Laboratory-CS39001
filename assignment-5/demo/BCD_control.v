`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:42:25 09/13/2022 
// Design Name: 
// Module Name:    BCD_control 
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
module BCD_control(digit0, digit1, digit2, digit3, refresh_counter, out_digit);
	input [3:0] digit0, digit1, digit2, digit3;
	input [1:0] refresh_counter;
	output reg [3:0] out_digit = 0;
	
	always@ (refresh_counter) begin
		case (refresh_counter)
			2'd0:
				out_digit = digit0;
			2'd1:
				out_digit = digit1;
			2'd2:
				out_digit = digit2;
			2'd3:
				out_digit = digit3;
		endcase
	end

endmodule
