`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:29:52 06/26/2015
// Design Name:   multiply_fp
// Module Name:   E:/Mode7/src/multiplytest.v
// Project Name:  src
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: multiply_fp
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module multiplytest;

	// Inputs
	reg [23:0] a;
	reg [23:0] b;

	// Outputs
	wire [23:0] out;

	// Instantiate the Unit Under Test (UUT)
	multiply_fp uut (
		.a(a), 
		.b(b), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		a = 24'b000000000000000110000000;
		b = 24'b000000000000001000000000;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

