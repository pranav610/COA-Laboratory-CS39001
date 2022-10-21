`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:59:48 09/13/2022 
// Design Name: 
// Module Name:    counter 
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
module counter(counter_clock, switch, rst, counter);
	input wire counter_clock;
	input wire switch;
	input wire rst;
	output reg [3:0] counter = 0;
	
	always@ (posedge counter_clock or posedge rst) begin
		if(rst == 1) counter <= 4'd0;
		else begin
			if(switch == 0) counter <= counter;
			if(switch == 1) counter <= counter + 1;
		end
	end

endmodule
