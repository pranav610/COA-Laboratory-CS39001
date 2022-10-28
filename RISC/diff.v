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
	
	// binary_to_bcd g2 (.diff(diff_32), .diff_out(diff), .eq(eq));
	
	case(diff_32)
			32'b10000000000000000000000000000000: begin diff_out = 6'd32;	eq = 1'b0; end
			32'b01000000000000000000000000000000: begin diff_out = 6'd31;	eq = 1'b0; end
			32'b00100000000000000000000000000000: begin diff_out = 6'd30;	eq = 1'b0; end
			32'b00010000000000000000000000000000: begin diff_out = 6'd29;	eq = 1'b0; end
			32'b00001000000000000000000000000000: begin diff_out = 6'd28;	eq = 1'b0; end
			32'b00000100000000000000000000000000: begin diff_out = 6'd27;	eq = 1'b0; end
			32'b00000010000000000000000000000000: begin diff_out = 6'd26;	eq = 1'b0; end
			32'b00000001000000000000000000000000: begin diff_out = 6'd25;	eq = 1'b0; end
			32'b00000000100000000000000000000000: begin diff_out = 6'd24;	eq = 1'b0; end
			32'b00000000010000000000000000000000: begin diff_out = 6'd23;	eq = 1'b0; end
			32'b00000000001000000000000000000000: begin diff_out = 6'd22;	eq = 1'b0; end
			32'b00000000000100000000000000000000: begin diff_out = 6'd21;	eq = 1'b0; end
			32'b00000000000010000000000000000000: begin diff_out = 6'd20;	eq = 1'b0; end
			32'b00000000000001000000000000000000: begin diff_out = 6'd19;	eq = 1'b0; end
			32'b00000000000000100000000000000000: begin diff_out = 6'd18;	eq = 1'b0; end
			32'b00000000000000010000000000000000: begin diff_out = 6'd17;	eq = 1'b0; end
			32'b00000000000000001000000000000000: begin diff_out = 6'd16;	eq = 1'b0; end
			32'b00000000000000000100000000000000: begin diff_out = 6'd15;	eq = 1'b0; end
			32'b00000000000000000010000000000000: begin diff_out = 6'd14;	eq = 1'b0; end
			32'b00000000000000000001000000000000: begin diff_out = 6'd13;	eq = 1'b0; end
			32'b00000000000000000000100000000000: begin diff_out = 6'd12;	eq = 1'b0; end
			32'b00000000000000000000010000000000: begin diff_out = 6'd11;	eq = 1'b0; end
			32'b00000000000000000000001000000000: begin diff_out = 6'd10;	eq = 1'b0; end
			32'b00000000000000000000000100000000: begin diff_out = 6'd9;		eq = 1'b0; end
			32'b00000000000000000000000010000000: begin diff_out = 6'd8;		eq = 1'b0; end
			32'b00000000000000000000000001000000: begin diff_out = 6'd7;		eq = 1'b0; end
			32'b00000000000000000000000000100000: begin diff_out = 6'd6;		eq = 1'b0; end
			32'b00000000000000000000000000010000: begin diff_out = 6'd5;		eq = 1'b0; end
			32'b00000000000000000000000000001000: begin diff_out = 6'd4;		eq = 1'b0; end
			32'b00000000000000000000000000000100: begin diff_out = 6'd3;		eq = 1'b0; end
			32'b00000000000000000000000000000010: begin diff_out = 6'd2;		eq = 1'b0; end
			32'b00000000000000000000000000000001: begin diff_out = 6'd1;		eq = 1'b0; end
			32'b00000000000000000000000000000000: begin diff_out = 6'd0;		eq = 1'b1; end
		endcase
	

endmodule
