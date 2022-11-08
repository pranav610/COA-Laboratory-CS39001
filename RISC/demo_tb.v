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
	reg clk;
	reg rst;
	reg RAMSel;
	reg button;

	// Outputs
	wire [15:0] out;

	// Instantiate the Unit Under Test (UUT)
	demo_wrapper uut (
		.clk(clk), 
		.rst(rst), 
		.RAMSel(RAMSel), 
		.button(button), 
		.out(out)
	);
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		RAMSel = 0;
		button = 0;

		// Wait 100 ns for global reset to finish
		#10;
		rst = 0;
		#50000;
		RAMSel = 1;
		#50;
		button = 1;
		#50;
		button = 0;
		#50;
		button = 1;
		#50;
		button = 0;
		#50;
		button = 1;
		#50;
		button = 0;
		#50;
		button = 1;
		#50;
		button = 0;
		#50;
		button = 1;
		#50;
		button = 0;
		#50;
		button = 1;
		#50;
		button = 0;
		#50;
		button = 1;
		#50;
		button = 0;
		#50;
		button = 1;
		#50;
		button = 0;
		#50;
		button = 1;
		#50;
		button = 0;
		#50;
		button = 1;
		#50;
		button = 0;
		#50;
		button = 1;
		#50;
		button = 0;
		#50;
		button = 1;
        
		// Add stimulus here

	end
      
endmodule

