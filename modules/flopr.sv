module flopr
				#(parameter N = 64) // name and default value
				(input logic clk,
				 input logic reset,
				 input logic [N-1:0] d,
				 output logic [N-1:0] q);

always_ff @(posedge clk, posedge reset)
if (reset) q <= 4'b0;
else q <= d;
endmodule