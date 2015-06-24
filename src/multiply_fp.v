`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:41:54 06/24/2015 
// Design Name: 
// Module Name:    multiply_fp 
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
`define K 8'b10000000
`define Q 4'b1000

module multiply_fp#(parameter SIZE=16,parameter INT_SIZE = 8, parameter DEC_SIZE = 8)(
	input [SIZE-1:0] a,
    input [SIZE-1:0] b,
    output reg [SIZE-1:0] out
    );
	 
	reg [SIZE*2-1:0] temp;
	reg sign;
	
	always @* begin
		sign = a[SIZE-1] ^ b[SIZE-1];
		temp = ({1'b0, a[SIZE-2:0]} * {1'b0, b[SIZE-2:0]}) + `K;
		temp = (temp >> `Q);
				
		out = {sign, temp[SIZE-2:0]};
		
	end

endmodule
