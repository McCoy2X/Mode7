`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:07:09 07/01/2015 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div
(
	input reset,
	input clk,
	output out
);
	
	localparam in_frequency = 32'd100000000;
	localparam out_frequency = 32'd50;
	localparam counter_bits = 40;
	
	reg [counter_bits-1:0] counter_reg;
	wire [counter_bits-1:0] counter_next;
	wire [counter_bits-1:0] increment;
	
	always @(posedge clk, posedge reset) begin
		if (reset)
			counter_reg <= 0;			
		else
			counter_reg <= counter_next;
	end
	
	assign increment = counter_reg[counter_bits-1] ? (out_frequency) : (out_frequency - in_frequency);
	assign counter_next = counter_reg + increment;
	
	assign out = ~counter_reg[counter_bits-1];
	
endmodule
