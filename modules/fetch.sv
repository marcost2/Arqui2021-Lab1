module fetch #(parameter N = 64)
					(input logic PCSrc_F, clk, reset,
					input logic [N-1:0] PCBranch_F,
					output logic [N-1:0] imem_addr_F);
	logic [63:0] result_adder;
	logic [63:0] pc_final;
	
	adder Add (.a(imem_addr_F), .b(64'b100), .y(result_adder));
		
	mux2 MUX (.d0(result_adder), .d1(PCBranch_F), .s(PCSrc_F), .y(pc_final));
	
	flopr PC (.clk(clk), .reset(reset), .d(pc_final), .q(imem_addr_F));

endmodule