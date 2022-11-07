`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:24:01 10/28/2022 
// Design Name: 
// Module Name:    register_file 
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
module register_file(
	input[4:0] regWrite,
	input[4:0] readReg1,
	input[4:0] readReg2,
	input[4:0] writeReg,
	input[31:0] writeData,
	input clk,
	input rst,
	output[31:0] readData1,
	output[31:0] readData2
   );
	
	reg [31:0] r[31:0];
	reg [31:0] i;
	
	assign readData1 = r[readReg1];
	assign readData2 = r[readReg2];
	
	always @(posedge clk or posedge rst)
	begin
		if (rst) for (i = 0; i <= 31; i = i+1) r[i] = 32'b00000000000000000000000000000000;
		else if (regWrite) r[writeReg] = writeData;
	end

endmodule
