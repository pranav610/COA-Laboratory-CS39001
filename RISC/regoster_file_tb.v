`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:04:49 11/08/2022
// Design Name:   register_file
// Module Name:   /home/vapippal/IIT KGP Docs/SEM 5/COA Lab/COA-Laboratory-CS39001/RISC/register_file_tb.v
// Project Name:  RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: register_file
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module register_file_tb;

	// Inputs
	reg regWrite;
	reg [4:0] readReg1;
	reg [4:0] readReg2;
	reg [4:0] writeReg;
	reg [31:0] writeData;
	reg clk;
	reg rst;

	// Outputs
	wire [31:0] readData1;
	wire [31:0] readData2;

	// Instantiate the Unit Under Test (UUT)
	register_file uut (
		.regWrite(regWrite), 
		.readReg1(readReg1), 
		.readReg2(readReg2), 
		.writeReg(writeReg), 
		.writeData(writeData),
		.clk(clk),
		.rst(rst),
		.readData1(readData1), 
		.readData2(readData2)
	);

	initial begin
		// Initialize Inputs
		regWrite = 0;
		readReg1 = 0;
		readReg2 = 0;
		writeReg = 0;
		writeData = 0;
		clk = 0;
		rst = 0;
	end
	
	always #10 clk = ~clk;
	
	initial begin
		// $monitor($time, " Addr1 = %d, readData1 = %d, Addr2 = %d, readData2 = %d", readReg1, readReg2, readData1, readData2);      
		#10
		rst = 1;
		#10
		rst = 0;
		
		#20; regWrite = 1; writeReg = 5'd1; writeData = 32'd68;
		#20; regWrite = 1; writeReg = 5'd2; writeData = 32'd82;
		#20; regWrite = 0; readReg1 = 5'd1; readReg2 = 5'd2;

	end
      
endmodule

