`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:23:39 09/14/2022 
// Design Name: 
// Module Name:    counter_4_bit 
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
module counter_4_bit(clk, switch, rst, counter);
	input clk, switch, rst;
	output reg [3:0] counter = 4'b0000;
	
	wire counter_clock; // 10 Hz clock to update counter
		
	clock_divider clk1(.clk(clk), .out_clk(counter_clock)); // 10 Hz Clock divider
	
	always@ (posedge counter_clock or posedge rst) begin
		if(rst == 1) counter <= 4'b0000;
		else begin
			if(switch == 0) counter <= counter;
			if(switch == 1) counter <= counter + 4'b0001;
		end
	end

endmodule
