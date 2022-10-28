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
	input [3:0] ALUop,
	input [4:0] shamt,
	input ena, 
	output reg [31:0] result,
	output fZero,
	output fSign,
	output reg fCarry
    );
	 
	wire [31:0] res_a, res_add, res_AND, res_XOR, res_shift; // various results
	wire [5:0] res_diff;
	
	// for complement
	wire [31:0] inv_b, sel_b;
	assign inv_b = ~b;
	assign sel_b = (ALUop[2] && ALUop[0]) ? inv_b : b;
	wire [31:0] const, sel_a;
	assign const_one = 32'd1;
	assign sel_a = (ALUop[2] && ALUop[0]) ? const_one : a;
	
	// for shift
	wire [4:0] shift; // based on our ALUop-code, shift can be shamt or b[4:0]
	assign shift = ALUop[2] ? b[4:0] : shamt; 
	
	// storing operation results
	assign res_a = a;
	adder32 add1 (.A(sel_a), .B(sel_b), .c_in(1'b0), .sum(res_add), .c_out(cout));
	assign res_AND = a & b;
	assign res_XOR = a ^ b;
	shifter shift1 (.in(a), .shamt(shift), .left(ALUop[1]), .logical(ALUop[0]), .out(res_shift));
	diff diff1 (.A(a), .B(b), .diff(res_diff));
	
	always @(posedge ena)
	begin
		if (ALUop[3]) begin result = res_shift; fCarry = 1'b0; end
		else if (ALUop == 4'b0100) begin result = res_diff; fCarry = 1'b0; end
		else if (ALUop == 4'b0010) begin result = res_AND; fCarry = 1'b0; end
		else if (ALUop == 4'b0011) begin result = res_XOR;	fCarry = 1'b0; end
		else if (ALUop == 4'b0001) begin result = res_add; fCarry = cout; end
		else if (ALUop == 4'b0101) begin	result = res_add; fCarry = 1'b0; end
		else begin result = res_a; fCarry = 1'b0; end
	end
	
	assign fZero = (result == 32'b0);
	assign fSign = result[31];
	
endmodule
