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
	parameter entTabla=15,
	salidaTabla=15,
	tamanioColor = 8,
	entradaImagen = 12
)
(
    input clk,
    input reset,
    input [7:0] color,
    output hsync,
    output vsync,
    output ptick,
    output von,
    output [7:0] rgb
    );

	wire [9:0] pixel_x, pixel_y;
	reg [9:0] offsety, offsety_next;
	reg [21:0] ctr_div, ctr_next;
	wire video_on, pixel_tick;
	wire [7:0] rgb_out;
	reg [7:0] rgb_reg;
	
	//wire clkdiv;

	vga_sync vga_unit	(.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
		.video_on(video_on), .p_tick(pixel_tick),
		.pixel_x(pixel_x), .pixel_y(pixel_y));
		
		
//	reg [15:0] sen, cos;
	reg [salidaTabla-1:0] array_sen [entTabla-1:0];
	reg [salidaTabla-1:0] array_cos [entTabla-1:0];
	reg [tamanioColor-1:0] array_img [entradaImagen-1:0];
		
	always @(posedge clk)
		if (pixel_tick)
			rgb_reg <= rgb_out;
		
	always @(posedge clk)
		if (reset)
			begin
				ctr_div <= 0;
				offsety <= 0;
			end
		else
			begin
				ctr_div <= ctr_next;
				offsety <= offsety_next;
			end
		
	always @*
		begin
			ctr_next = ctr_div;
			offsety_next = offsety;
			if (ctr_div == 22'd2097152)
				begin
					ctr_next = 0;
					offsety_next = offsety + 1;
				end
			else
				begin
					ctr_next = ctr_div + 1;
					offsety_next = offsety;
				end
		end

	assign rgb = rgb_reg;
	assign ptick = pixel_tick;
	assign von = video_on;

endmodule
