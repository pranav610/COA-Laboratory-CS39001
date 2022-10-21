`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:35:40 09/13/2022 
// Design Name: 
// Module Name:    refresh_counter 
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
module refresh_counter(input refresh_clock, output reg [1:0] refresh_counter=0);
always@ (posedge refresh_clock) refresh_counter <= refresh_counter + 1;


endmodule
