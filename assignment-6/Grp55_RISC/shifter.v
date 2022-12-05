`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:40:46 10/21/2022 
// Design Name: 
// Module Name:    shifter 
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
module shifter(
	input signed [31:0] in,		// input number
	input [4:0] shamt,			// shift amount
	input left,						// direction of shifting: 1 for left-shift, 0 otherwise
	input logical,					// 1 if logical, 0 if arithmetic
	output reg [31:0] out		// output number, 32 bits
    );

    always @(*) begin
        if (logical == 0) begin
            if (left == 1) begin
                out = in;				 // arithmetic left shift
            end
            else begin
                out = in >>> shamt;  // arithmetic right shift
            end
        end
        else begin
            if (left == 1) begin
                out = in << shamt;   // logical left shift
            end
            else begin
                out = in >> shamt;   // logical right shift
            end
        end
    end

endmodule
