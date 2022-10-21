`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:24:33 10/20/2022 
// Design Name: 
// Module Name:    ALU 
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
// ALU module to perform arithmetic operations and compute flags
// Inputs : a(32-bits), b(32-bits), op(4-bits), shamt (Instruction[15:11])
// Outputs : result(32-bits) and fZero, fSign, fCarry (1-bit each)
module ALU(
	input	[31:0] a,
	input [31:0] b,
	input [3:0] op,
	input [4:0] shamt,
	output reg [31:0] result,
	output fZero,
	output fSign,
	output reg fCarry
    );
	 
	wire [31:0] res_a, res_add, res_AND, res_XOR, res_shift; // various results
	
	// for complement
	wire [31:0] inv_b, sel_b;
	assign inv_b = ~b;
	assign sel_b = op[2] ? inv_b : b;
	wire [31:0] const, sel_a;
	assign const = 32'd1;
	assign sel_a = op[2] ? const : a;
	
	// for shift
	wire [4:0] shift; // based on our op-code, shift can be shamt or b[4:0]
	assign shift = op[2] ? shamt : b[4:0]; 
	
	// storing operation results
	assign res_a = a;
	adder32 add1 (.A(sel_a), .B(sel_b), .c_in(0), .sum(res_add), .c_out(cout));
	assign res_AND = a & b;
	assign res_XOR = a ^ b;
	shifter shift1 (.in(a), .shamt(shift), .left(~op[0]), .logical(~op[1]), .out(res_shift));
	
	always @(*)
	begin
		if (op[3]) 					result = res_shift;
		else if (op == 4'b0010) result = res_AND;
		else if (op == 4'b0011) result = res_XOR;
		else if (op == 4'b0001)
		begin
			result = res_add;
			fCarry = cout;
		end
		else if (op == 4'b0101)	result = res_add;
		else							result = res_a;
	end
	
	assign fZero = (result == 32'b0);
	assign fSign = result[31];
	
endmodule
