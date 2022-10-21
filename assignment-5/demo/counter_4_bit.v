`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:40:06 09/13/2022 
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
module counter_4_bit(clk, switch, rst, anode, cathode);
	input wire clk, switch, rst;
	output wire [3:0] anode;
	output wire [7:0] cathode;
	
	wire refresh_clock; // 10 KHz clock to load digits to cathode
	wire counter_clock; // 10 Hz clock to update counter
	
	wire [3:0] ones, tens, counter;
	
	clock_divider clk1(.clk(clk), .out_clk(counter_clock)); // 10 Hz Clock divider
	clock_divider_10khz clk2(.clk(clk), .out_clk(refresh_clock)); // 10KHz Clock divider
	counter count_4_bit(.counter_clock(counter_clock), .switch(switch), .rst(rst), .counter(counter));
	binary_to_bcd converter1(.clk(clk), .in_4_bit_bin(counter), .ones(ones), .tens(tens));
	bcd_to_7_segment converter2(.refresh_clock(refresh_clock), .ones(ones),  .tens(tens), .anode(anode), .cathode(cathode));

endmodule
