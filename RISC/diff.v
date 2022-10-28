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
module diff(A, B, diff, eq);
	input [31:0] A;
	input [31:0] B;
	output [5:0] diff;
	output eq;
  
	wire [31:0] n, n_1, n_n_1_xor, diff_32;
	wire cout1 ;
	
	assign n = A ^ B;
	adder32 g1 (n, 32'b11111111111111111111111111111111, 1'b0, n_1, cout1);
	assign n_n_1_xor = n ^ n_1;
	assign diff_32 = n_n_1_xor & n;
	
	binary_to_bcd g2 (.diff(diff_32), .diff_out(diff), .eq(eq));
	

endmodule
