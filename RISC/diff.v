`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:15:53 10/21/2022 
// Design Name: 
// Module Name:    diff 
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
// module to perform the diff operation: i.e. to find the LSB bit where A and B differ
module diff(
	input [31:0] A,
	input [31:0] B,
	output [4:0] d
    );
	
	// calculating the LSB
	reg [31:0] n = A ^ B;
	reg [31:0] cnt = n & (n ^ (n-1)); // cnt has 0 bits at every position except the diff LSB of A and B
	

endmodule
