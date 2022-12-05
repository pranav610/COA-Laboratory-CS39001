`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:48:07 11/09/2022 
// Design Name: 
// Module Name:    clock_divider 
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
module clock_divider(clk, out_clk);
	input wire clk;
	output reg out_clk;
	
	integer counter = 0;
	
	always@ (posedge clk)
	begin
		if(counter == 49999999) begin
			counter <= 0;
			out_clk <= ~out_clk;
		end else begin
			counter <= counter + 1;
			out_clk <= out_clk;
		end 
	end

endmodule
