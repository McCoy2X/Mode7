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
		input [7:0] color,
		input [7:0] offsetx,
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
	reg [7:0] rgb_out;
	reg [7:0] rgb_reg;
	
	//wire clkdiv;

	vga_sync vga_unit	(.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
		.video_on(video_on), .p_tick(pixel_tick),
		.pixel_x(pixel_x), .pixel_y(pixel_y));
		
	reg [15:0] sen, cos;
	wire [8:0] angle;
	reg [15:0] array_sen [359:0];
	reg [15:0] array_cos [359:0];
	reg [7:0] array_img [4095:0];
	
	initial begin
		$readmemb("cos.bin", array_cos, 0, 359);
		$readmemb("sin.bin", array_sen, 0, 359);
		$readmemb("bitmap.bin", array_img, 0, 4095);
	end
		
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
			
			rgb_out = 8'b00000000;
			if(pixel_x < 64 + offsetx && pixel_y < 64) begin
				rgb_out = array_img[pixel_x + pixel_y * 64];
			end else if(pixel_x < 640 && pixel_y < 480) begin
				rgb_out = 8'b11111111;
			end
						
			/*if (ctr_div == 22'd2097152) begin
				ctr_next = 0;
				offsety_next = offsety + 1;
			end else	begin
				ctr_next = ctr_div + 1;
				offsety_next = offsety;
			end*/
		end

	assign rgb = rgb_reg;
	assign ptick = pixel_tick;
	assign von = video_on;

endmodule
