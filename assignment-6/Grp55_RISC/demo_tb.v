`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:16:50 11/09/2022
// Design Name:   demo_wrapper
// Module Name:   /home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/RISC/demo_tb.v
// Project Name:  RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: demo_wrapper
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module demo_tb;

	// Inputs
	reg clk100mhz;
	reg rst;
	reg sel;
	reg [9:0] inp;

	// Outputs
	wire [15:0] out;

	// Instantiate the Unit Under Test (UUT)
	demo_wrapper uut (
		.clk100mhz(clk100mhz), 
		.rst(rst), 
		.sel(sel), 
		.inp(inp), 
		.out(out)
	);
	
	always #5 clk100mhz = ~clk100mhz;

	initial begin
		// Initialize Inputs
		clk100mhz = 0;
		rst = 1;
		sel = 0;
		inp = 0;

		// Wait 100 ns for global reset to finish
		#10;
		rst = 0;
		#50000;
		sel = 1;
		#50;
		inp = 10'd0;
		#50;
		inp = 10'd1;
		#50;
		inp = 10'd2;
		#50;
		inp = 10'd3;
		#50;
		inp = 10'd4;
		#50;
		inp = 10'd5;
		#50;
		inp = 10'd6;
		#50;
		inp = 10'd7;
		
        
		// Add stimulus here

	end
      
endmodule

