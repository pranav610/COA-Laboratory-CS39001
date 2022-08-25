`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:31:11 08/25/2022 
// Design Name: 
// Module Name:    halfAdder 
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
module halfAdder(f, a, b, sel);
output f;
input a,b,sel;
wire f1,f2,nsel;

and g1(f1,a,nsel);
and g2(f2, b, sel);
or g3(f, f1, f2);
not g4(nsel, sel);	 

endmodule
