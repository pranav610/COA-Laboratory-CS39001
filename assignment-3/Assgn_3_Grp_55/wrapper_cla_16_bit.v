`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:09:22 08/31/2022 
// Design Name: 
// Module Name:    wrapper_cla_16_bit 
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
module wrapper_cla_16_bit(input clk, input rst, input [15:0] in1, input [15:0] in2, input cnet, output reg [15:0] out, output reg [3:0] P, output reg[3:0] G, output reg c);

reg [15:0] in1_reg;
reg [15:0] in2_reg;
reg cin;
wire [15:0] out_net;
wire [3:0] P_out, G_out;
wire cout;
always @(posedge clk)
    begin
        if(rst)
            begin
                in1_reg<=16'd0;
                in2_reg<=16'd0;
					 cin<=1'b0;
					 out<=16'd0;
					 P<=4'd0;
					 G<=4'd0;
					 c<=1'b0;
            end
        else
            begin
                in1_reg<=in1;
                in2_reg<=in2;
					 cin<=cnet;
					 out<=out_net;
					 P<=P_out;
					 G<=G_out;
					 c<=cout;
            end
    end

cla_16_bit g(in1_reg, in2_reg, cin, out_net, cout, P_out, G_out);

endmodule
