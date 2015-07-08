`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:30:55 07/08/2015 
// Design Name: 
// Module Name:    sevenSegDisplay 
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
module sevenSegDisplay(
		input wire clk, reset, 
		input wire [23:0] value,
		output wire [7:0] seg, [3:0]an
   );

	wire [7:0]ssegment0;
	wire [7:0]ssegment1;
	wire [7:0]ssegment2;
	wire [7:0]ssegment3;
	hex_to_sseg htoseg0 (.hex(value[19:16]), .dp(1'b1), .sseg(ssegment0));
	hex_to_sseg htoseg1 (.hex(value[15:12]), .dp(1'b1), .sseg(ssegment1));
	hex_to_sseg htoseg2 (.hex(value[11:8]), .dp(1'b1), .sseg(ssegment2));
	hex_to_sseg htoseg3 (.hex(value[4:0]), .dp(1'b1), .sseg(ssegment3));
	disp_mux disp (.clk(clk), .reset(reset), .in3(ssegment0), .in2(ssegment1), .in1(ssegment2), .in0(ssegment3), .an(an), .sseg(seg));

endmodule
