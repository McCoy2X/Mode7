`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:49:21 06/26/2015 
// Design Name: 
// Module Name:    getXY 
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
module getXY(
		input wire [15:0] x, y,
		input wire [15:0] originx, originy,
		input wire [15:0] offsetx, offsety,
		input wire [15:0] texturew, textureh,
		input wire [9:0] angle,
		output reg [7:0] color,
		output wire [23:0] X, Y
	);
	
	reg [15:0] array_sen [359:0];
	reg [15:0] array_cos [359:0];
	reg [7:0] array_img [4095:0];
	
	reg [15:0] sen, cos;
	
	initial begin
		$readmemb("cos.bin", array_cos, 0, 359);
		$readmemb("sin.bin", array_sen, 0, 359);
		$readmemb("bitmap.bin", array_img, 0, 4095);
	end
	
	wire [15:0]aa;
	wire [15:0]ba;
	wire [15:0]ca;
	wire [15:0]da;

	assign aa = array_cos[angle];
	assign ba = array_sen[angle];
	assign ca = array_sen[angle];
	assign da = array_cos[angle];
	
	wire [23:0]Xminusx0;
	wire [23:0]Yminusy0;
	wire [23:0]amulXminusx0;
	wire [23:0]bmulYminusy0;
	wire [23:0]cmulXminusx0;
	wire [23:0]dmulYminusy0;
	
	wire [23:0]resSumAB;
	wire [23:0]resSumCD;
	
	wire [23:0]resX;
	wire [23:0]resY;
	
	sum SumXminusx0 (.a({x, 8'b00000000}), .b({1'b1, originx[14:0], 8'b00000000}), .out(Xminusx0));
	sum SumYminusy0 (.a({y, 8'b00000000}), .b({1'b1, originy[14:0], 8'b00000000}), .out(Yminusy0));
	
	multiply_fp MulamulXminusx0 (.a({aa[15], 8'b00000000, aa[14:0]}), .b(Xminusx0), .out(amulXminusx0));
	multiply_fp MulbmulXminusx0 (.a({ba[15], 8'b00000000, ba[14:0]}), .b(Yminusy0), .out(bmulYminusy0));
	multiply_fp MulcmulYminusy0 (.a({1'b1, 8'b00000000, ca[14:0]}), .b(Xminusx0), .out(cmulXminusx0));
	multiply_fp MuldmulYminusy0 (.a({da[15], 8'b00000000, da[14:0]}), .b(Yminusy0), .out(dmulYminusy0));
	
	sum SumresSumAB (.a(amulXminusx0), .b(bmulYminusy0), .out(resSumAB));
	sum SumresX (.a(resSumAB), .b({originx, 8'b00000000}), .out(resX));
	
	sum SumresSumCD (.a(cmulXminusx0), .b(dmulYminusy0), .out(resSumCD));
	sum SumresY (.a(resSumCD), .b({originy, 8'b00000000}), .out(resY));
	
	assign X = resX;
	assign Y = resY;

	always @* begin
		color = 8'b00000000;
		if(x < texturew && y < textureh) begin
			color = array_img[resX[23:8] + resY[23:8] * 64];
			//color = array_img[x + y * 64];
		end else if(x < 640 && y < 480) begin
			color = 8'b11111111;
		end
	end

endmodule
