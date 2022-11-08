`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:33 10/28/2022 
// Design Name: 
// Module Name:    ALU_control 
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
module ALU_control(opCode, funCode, ALUop);
input [5:0] opCode;
input [4:0] funCode;
output reg [3:0] ALUop;

always @(*) begin
		 if (opCode[5] == 1)
		     ALUop = 4'b0;
		 else if (opCode == 6'b0)
		     ALUop = funCode[3:0];
		 else if (opCode == 6'b001000 || opCode[5:4] == 2'b01)
		     ALUop = 4'b0001;
		 else if (opCode == 6'b001001)
		     ALUop = 4'b0101;
		 else if(opCode == 6'b001111)
			  ALUop = 4'b0100;
       else 
           ALUop = 4'b0000;		 
	 end
endmodule