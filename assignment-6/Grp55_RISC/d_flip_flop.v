`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:50:15 10/24/2022 
// Design Name: 
// Module Name:    d_flip_flop 
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
module d_flip_flop(in, clk, rst, out);
	
	input in, clk, rst;
	output reg out;
    
	 
	 always @(posedge clk or posedge rst) begin
	     if(rst)
		      out <= 1'b0;
		  else 
				out <= in;
	 end
endmodule