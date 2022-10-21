`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:38:12 09/13/2022 
// Design Name: 
// Module Name:    anode_control 
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
module anode_control(refresh_counter, anode);
	input [1:0] refresh_counter;
	output reg [3:0] anode = 0;
	
	always@ (refresh_counter) begin
		case(refresh_counter)
			2'b00:
				anode = 4'b1110; // digit 1 ON (rightmost digit)
			2'b01:
				anode = 4'b1101; // digit 2 ON 
			2'b10:
				anode = 4'b1011; // digit 3 ON
			2'b11:
				anode = 4'b0111; // digit 4 ON (leftmost digit)
		endcase
	end


endmodule
