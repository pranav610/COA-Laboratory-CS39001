`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:19:01 09/13/2022 
// Design Name: 
// Module Name:    bcd_to_7_segment 
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
////////////////////////////////////////////////////////////////// ////////////////
module bcd_to_7_segment(refresh_clock, ones,  tens, anode, cathode);
	input wire refresh_clock;
	input wire [3:0] ones;
	input wire [3:0] tens;
	output wire [3:0] anode;
	output wire [7:0] cathode;
	
	wire [1:0] refresh_counter;
	wire [3:0] out_digit;
	
	refresh_counter refresh_counter_wrapper(.refresh_clock(refresh_clock), .refresh_counter(refresh_counter));
	anode_control anode_controller (.refresh_counter(refresh_counter), .anode(anode));
	BCD_control bcd_controller(.digit0(ones), .digit1(tens), .digit2(4'd0), .digit3(4'd0), .refresh_counter(refresh_counter), .out_digit(out_digit));
	bcd_to_cathode bcd_to_cathod_controller(.digit(out_digit), .cathode(cathode));
	
endmodule
