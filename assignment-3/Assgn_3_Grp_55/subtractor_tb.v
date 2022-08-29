`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:36:25 08/25/2022
// Design Name:   subtractor_tb
// Module Name:   ~/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/Assgn_3_Grp_55/subtractor_tb.v
// Project Name:  Assgn_3_Grp_55
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: full_adder_64_bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module substractor_tb;

	// Inputs
	reg [63:0] a = 64'd0;
	reg [63:0] b = 64'd0;
	reg [63:0] b_temp = 64'd0;
	reg cin = 1'b0;

	// Outputs
	wire cout;
	wire [63:0] sum;

	// Instantiate the Unit Under Test (UUT)
	full_adder_64_bit uut (
		.a(a),
		.b(b),
		.cin(cin),
		.cout(cout),
		.sum(sum)
	);

	initial begin
        a = 0;
        b = 0;
        cin = 0;

		// To print changes
		$monitor ("a = %d, b = %d, carry_in = %d, carry_out = %d, a-b = %d", a, b_temp, cin, cout, sum);

		// Wait 100 ns for global reset to finish
        // #100;

		// Add stimulus here
        a = 64'd81277482720;
        b = 64'd446278127;
		  b_temp = 64'd446278127;
        b = ~b;			// ones complement of b
        cin = 1'b1;		// this carry in will add 1 to ones complement of b
        
        #5

        a = 64'd1400000000000000;
        b = 64'd1000000000000000;
		  b_temp = 64'd1000000000000000;
        b = ~b;			// ones complement of b
        cin = 1'b1;		// this carry in will add 1 to ones complement of b
        
        #5
        
        a = 64'd928391830841483;
        b = 64'd928391830841483;
		  b_temp = 64'd928391830841483;
        b = ~b;			// ones complement of b
        cin = 1'b1;		// this carry in will add 1 to ones complement of b
        
		#5 $finish;

	end
    
endmodule

