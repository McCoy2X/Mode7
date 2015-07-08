`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:37:47 06/24/2015 
// Design Name: 
// Module Name:    Mode7 
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
module Mode7
	#(
		parameter
		entTabla = 360,
		salidaTabla = 16,
		tamanioColor = 8,
		entradaImagen = 4096
	)
	(
		input clk,
		input reset,
		input [7:0] switches,
		input btn_plus,
		input btn_minus,
		output hsync,
		output vsync,
		output ptick,
		output von,
		output [7:0] rgb
   );

	wire video_on, pixel_tick;
	
	wire [9:0] pixel_x, pixel_y;
	
	wire [7:0] rgb_out;
	reg [7:0] rgb_reg;
	
	wire [23:0] offsetx, offsety, originx, originy, texturew, textureh, scalex, scaley, angle;
	
	wire [23:0] X, Y;
	
	//wire clkdiv;

	vga_sync vga_unit	(.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
		.video_on(video_on), .p_tick(pixel_tick),
		.pixel_x(pixel_x), .pixel_y(pixel_y));
		
	valueManager values (
		.clk(clk),
		.reset(reset),
		.switches(switches),
		.btn_plus(btn_plus),
		.btn_minus(btn_minus),
		.offsetx(offsetx),
		.offsety(offsety),
		.originx(originx),
		.originy(originy),
		.texturew(texturew),
		.textureh(textureh),
		.scalex(scalex),
		.scaley(scaley),
		.angle(angle));
		
	getXY getXYColor (
		.x({6'b000000,pixel_x}), 
		.y({6'b000000,pixel_y}), 
		.originx(originx[23:8]), 
		.originy(originy[23:8]), 
		.offsetx(offsetx[23:8]), 
		.offsety(offsety[23:8]), 
		.texturew(texturew[23:8]), 
		.textureh(textureh[23:8]), 
		.scalex(scalex), 
		.scaley(scaley), 
		.angle(angle[23:8]), 
		.X(X),
		.Y(Y),
		.color(rgb_out));
		
	always @(posedge clk) begin
		if (pixel_tick)
			rgb_reg <= rgb_out;
	end

	assign rgb = rgb_reg;
	assign ptick = pixel_tick;
	assign von = video_on;

endmodule
