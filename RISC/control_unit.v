`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:54:15 10/21/2022 
// Design Name: 
// Module Name:    control_unit 
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
module control_unit(opCode, regDest, regWrite, ALUsrc, MemRead, MemWrite, MemToReg, LblSel, JumpAddr);  
	 input  [5:0] opCode;
	 output regWrite, ALUsrc, MemRead, MemWrite, LblSel, JumpAddr;
	 output [1:0] regDest, MemToReg;
	 
	 assign regDest = {opCode[5], opCode[4]};
	 assign regWrite = (~opCode[5] & ~opCode[4]) |
							 (~opCode[5] & ~opCode[3]) |
							 ( opCode[1] &  opCode[0]);
	 assign ALUsrc = opCode[4] | opCode[3];
	 assign MemRead = (opCode == 6'b010000);
	 assign MemWrite = (opCode == 6'b011000);
	 assign MemToReg = opCode[5:4];
	 assign LblSel = opCode[5] & opCode[4];
	 assign JumpAddr = ~opCode[4] & ~opCode[3];
endmodule