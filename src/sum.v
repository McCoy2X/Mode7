`timescale 1ns / 1ps
`define UPPER_BOUND 16'b0111111111111111
`define SATURATED 16'b1111111111111111
module sum #(parameter SIZE=16)(
    input [SIZE-1:0] a,
    input [SIZE-1:0] b,
    output reg [SIZE-1:0] out
    );
	 
	 
	always @(*)
	begin
		case({a[SIZE-1],b[SIZE-1]})
			2'b00:
				begin
					if ((a[SIZE-2:0] + b[SIZE-2:0]) > `UPPER_BOUND)
						begin
							out = `UPPER_BOUND;
						end
					else
						begin
							out = a+b;
						end
				end
			2'b01:
				begin
					if ((a[SIZE-2:0] < b[SIZE-2:0]))
						begin
							out = {1'b1, b[SIZE-2:0] - a[SIZE-2:0]};
						end
					else
						begin
							out = {1'b0, a[SIZE-2:0] - b[SIZE-2:0]};
						end
				end
			2'b10:
				begin
					if ((a[SIZE-2:0] > b[SIZE-2:0]))
						begin
							out = {1'b1, a[SIZE-2:0] - b[SIZE-2:0]};
						end
					else
						begin
							out = {1'b0, b[SIZE-2:0] - a[SIZE-2:0]};
						end
				end
			2'b11:
				begin
					if ((a[SIZE-2:0] + b[SIZE-2:0]) > `UPPER_BOUND)
						begin
							out = `SATURATED;
						end
					else
						begin
							out = {1'b1,a[SIZE-2:0] + b[SIZE-2:0]};
						end
				end
			endcase
	end

endmodule
