`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:49:40 08/31/2022 
// Design Name: 
// Module Name:    wrapper_16_bit_cla_ripple 
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
module wrapper_16_bit_cla_ripple(input clk, input rst, input [15:0] in1, input[15:0] in2, input cnet, output reg [15:0] out, output reg c);
reg [15:0] in1_reg, in2_reg;
reg cin;
wire [15:0] out_net;
wire cout;

always @(posedge clk)
    begin
        if(rst)
            begin
                in1_reg<=16'd0;
                in2_reg<=16'd0;
					 cin<=1'b0;
					 out<=16'd0;
					 c<=1'b0;
            end
        else
            begin
                in1_reg<=in1;
                in2_reg<=in2;
					 cin<=cnet;
					 out<=out_net;
					 c<=cout;
            end
    end

cla_16bit_ripple g1(in1_reg, in2_reg, cin, cout, out_net);

endmodule
