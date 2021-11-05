module alu 
				#(parameter N = 64)
				(input logic [63:0] a,
				input logic [63:0] b,
				input logic [3:0] ALUControl,
				output logic [63:0] result,
				output logic zero, negative, Carry, overflow);
	logic [64:0] temp_result;
	always_comb
		begin
			casez(ALUControl)
				4'b0000: temp_result = a & b;
				4'b0001: temp_result = a | b;
				4'b0010: temp_result = a + b;
				4'b0110: temp_result = a - b;
				4'b0111: temp_result = b;
				4'b1100: temp_result = ~(a | b);
				default: temp_result = 65'b0;
			endcase
		end
	assign result = temp_result[63:0];
	assign zero = (result === 64'b0) ? 1'b1 : 1'b0;
	assign negative = (result[63] === 1'b1) ? 1'b1 : 1'b0;
	assign overflow = (ALUControl === 4'b0010) ? ((a[63] == b[63]) & (a[63] != result[63])) : 
	((ALUControl === 4'b0110) ? ((a[63] ^ b[63]) & (a[63] ^ result[63])) : 1'b0);
	assign Carry = temp_result[64];
endmodule