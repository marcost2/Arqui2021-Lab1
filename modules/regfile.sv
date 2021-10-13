module regfile (input logic clk, we3,
					 input logic [4:0] ra1, ra2, wa3,
					 input logic [63:0] wd3,
					 output logic [63:0] rd1, rd2);
	logic [63:0] regs [32];
	initial begin
		regs[31] = 0;
		for(int i = 0; i < 31; ++i) begin
			regs[i] = i;
		end
	end
	
	assign rd1 = (wa3==ra1 && (we3 && wa3 != 31)) ? wd3 : regs[ra1];
	assign rd2 = (wa3==ra2 && (we3 && wa3 != 31)) ? wd3 : regs[ra2];
	
	always @(posedge clk)
	begin
		if(we3 && (wa3 != 31)) regs[wa3] = wd3;
	end

endmodule