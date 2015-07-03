`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:59:30 07/01/2015 
// Design Name: 
// Module Name:    valueManager 
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
module valueManager(
		input clk,
		input reset,
		input [7:0] switches,
		input btn_plus,
		input btn_minus,
		output wire [23:0] offsetx, offsety, originx, originy, texturew, textureh, scalex, scaley, angle
   );
	 
	wire level_plus, level_minus;
	wire clk_slow;
	
	//0 reg [23:0] offsetx_reg;
	//1 reg [23:0] offsety_reg;
	//2 reg [23:0] originx_reg;
	//3 reg [23:0] originy_reg;
	//4 reg [23:0] texturew_reg;
	//5 reg [23:0] textureh_reg;
	//6 reg [23:0] scalex_reg;
	//7 reg [23:0] scaley_reg;
	//8 reg [23:0] angle_reg;
	 
	wire [23:0] outputPlus;
	wire [23:0] outputMinus;
	 
	reg [23:0] values[9:0];
	
	initial begin
		//values[0] = {16'b0000000010000000, 8'b00000000};
		//values[1] = {16'b0000000010000000, 8'b00000000};
	end

	sum valuePlusOne (.a(values[switches[3:0]]), .b({16'b0000000000000000, 8'b00000000}), .out(outputPlus));
	sum valueMinusOne (.a(values[switches[3:0]]), .b({16'b1000000100000000, 8'b00000000}), .out(outputMinus));
		
	debounce debounce_plus (
		.clk(clk),
		.reset(reset),
		.sw(btn_plus),
		.db_level(level_plus));
		
	debounce debounce_minus (
		.clk(clk),
		.reset(reset),
		.sw(btn_minus),
		.db_level(level_minus));
		
	clk_div clk_new (
		.clk(clk),
		.reset(reset),
		.out(clk_slow));

	always @(posedge clk_slow) begin
		if(reset) begin
			values[0] = {16'b0000000000000000, 8'b00000000};
			values[1] = {16'b0000000000000000, 8'b00000000};
			values[2] = {16'b0000000000000000, 8'b00000000};
			values[3] = {16'b0000000000000000, 8'b00000000};
			values[4] = {16'b0000000001000000, 8'b00000000};
			values[5] = {16'b0000000001000000, 8'b00000000};
			values[6] = {16'b0000000000000001, 8'b00000000};
			values[7] = {16'b0000000000000001, 8'b00000000};
			values[8] = {16'b0000000000000000, 8'b00000000};
		end
		else begin
			if(level_minus) begin
				values[switches[3:0]] = outputPlus;
			end else if(level_plus) begin
				values[switches[3:0]] = outputMinus;
			end
		end
	end
	
	assign offsetx = values[0];
	assign offsety = values[1];
	assign originx = values[2];
	assign originy = values[3];
	assign texturew = values[4];
	assign textureh = values[5];
	assign scalex = values[6];
	assign scaley = values[7];
	assign angle = values[8];
				
endmodule
