`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:48:18 06/26/2015
// Design Name:   getXY
// Module Name:   E:/Mode7/src/TESTSADASDAS.v
// Project Name:  src
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: getXY
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TESTSADASDAS;

	// Inputs
	reg [15:0] x;
	reg [15:0] y;
	reg [15:0] texturew;
	reg [15:0] textureh;
	reg [15:0] originx;
	reg [15:0] originy;
	reg [15:0] offsetx;
	reg [15:0] offsety;
	reg [9:0] angle;
	
	wire [23:0] X, Y;

	// Outputs
	wire [7:0] color;

	// Instantiate the Unit Under Test (UUT)
	getXY uut (
		.x(x), 
		.y(y), 
		.originx(originx), 
		.originy(originy), 
		.angle(angle), 
		.offsetx(offsetx), 
		.offsety(offsety), 
		.texturew(texturew), 
		.textureh(textureh), 
		.X(X),
		.Y(Y),
		.color(color)
	);

	initial begin
		// Initialize Inputs
		x = 10;
		y = 1;
		originx = 0;
		originy = 0;
		angle = 10;
		offsetx = 0;
		offsety = 0;
		texturew = 64;
		textureh = 64;

		// Wait 100 ns for global reset to finish
		#100;
      x = 10;
		  
		// Add stimulus here

	end
      
endmodule

