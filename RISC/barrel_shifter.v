`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:44:08 10/20/2022 
// Design Name: 
// Module Name:    barrel_shifter 
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
module barrel_shifter(
		input [31:0] A,			// input number
		input [4:0] shamt,		// shift amount
		input left,					// direction of shifting: 1 for left-shift, 0 otherwise
		output reg [63:0] out	// output of shifting
    );
		reg shift;
		reg index;
		
		always @(A or shamt or left)
		begin
			out = A;
			shift = 0;
			for (index = 0; index < 3; index = index + 1)
			begin
				if (shamt[index]) shift = shift + 2 ** index;
			end
			out = left? out << shift : out >> shift;
		end
endmodule
