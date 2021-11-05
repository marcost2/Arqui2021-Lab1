module alu 
				#(parameter N = 64)
				(input logic [63:0] a,
				input logic [63:0] b,
				input logic [3:0] ALUControl,
				output logic [63:0] result,
				output logic zero, negative, Carry, overflow, write_flags);
	//Ask if xor is bit to bit
	//assign b_comp = xor(b,ALUControl[2]) + ALUControl[2]
	always_comb
		begin
			casez(ALUControl)
				4'b0000: {Carry, result} = {1'b0 ,a & b};
				4'b0001: {Carry, result} = {1'b0, a | b};
				4'b?010: {Carry, result} = a + b;
				4'b?110: {Carry, result} = a + (~b + 64'b1);
				4'b0111: {Carry, result} = {1'b0, b};
				default: {Carry, result} = 65'b0;
			endcase
		end
	assign zero = (result === 64'b0) ? 1'b1 : 1'b0;
	assign negative = (result[63] === 1'b1) ? 1'b1 : 1'b0;
	/*
	assign overflow = (ALUControl === 4'b1010) ? ((a[63] == b[63]) & (a[63] != result[63])) : 
	((ALUControl === 4'b1110) ? ((a[63] ^ b[63]) & (a[63] ^ result[63])) : 1'b0);
	*/
	// version del gonza
	assign overflow = (ALUControl[1] == 1'b1) & ~(a[N-1] ^ b[N-1] ^ ALUControl[2]) & (a[N-1] ^ result[N-1]); 
	assign write_flags = ALUControl[3];
endmodule