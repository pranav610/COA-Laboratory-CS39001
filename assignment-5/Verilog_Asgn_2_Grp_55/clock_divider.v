`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:26:59 09/14/2022 
// Design Name: 
// Module Name:    clock_divider 
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
module clock_divider(clk, out_clk);
input wire clk;
output reg out_clk = 0;

integer counter = 0;
// 4999999 will give 10Hz output  

always@ (posedge clk)
begin
	if(counter == 4999999) begin
		counter <= 0;
		out_clk <= ~out_clk;
	end else begin
		counter <= counter + 1;
		out_clk <= out_clk;
	end
end

endmodule
