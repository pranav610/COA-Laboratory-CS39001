`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:55 09/13/2022 
// Design Name: 
// Module Name:    binary_to_bcd 
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
module binary_to_bcd(clk, in_4_bit_bin, ones, tens);
	input clk;
	input [3:0] in_4_bit_bin;
	output reg [3:0] ones = 0;
	output reg [3:0] tens = 0;
	
	reg [3:0] itr = 0;
	reg [3:0] ones_temp = 0;
	reg [3:0] tens_temp = 0;
	reg [11:0] shift = 0;
	reg [3:0] save_in = 0;
	
	always@ (posedge clk)
	begin
		if(itr == 0 & (save_in != in_4_bit_bin)) begin
			shift = 12'd0;
			save_in = in_4_bit_bin;
			shift[3:0] = in_4_bit_bin;
			tens_temp = shift[11:8];
			ones_temp = shift[7:4];
			itr = itr + 1;
		end
		if(itr < 5 & itr > 0)begin
			if(tens_temp >= 5) tens_temp = tens_temp + 3;
			if(ones_temp >= 5) ones_temp = ones_temp + 3;
			shift[11:4] = {tens_temp, ones_temp};
			// shift[11:8] = tens_temp;
			// shift[7:4] = ones_temp;
			shift = shift << 1;
			tens_temp = shift[11:8];
			ones_temp = shift[7:4];
			itr = itr + 1;
		end
		if(itr==5) begin
			itr = 0;
			tens = tens_temp;
			ones = ones_temp;
		end
	end
endmodule
