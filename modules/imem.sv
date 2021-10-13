module imem 
#(parameter N = 32) // name and default value
				(input logic [5:0] addr,
				 output logic [N-1:0] q);
		logic [N-1:0] ROM [64];

		initial 
           begin
           ROM = '{default:32'h00000000};
			  ROM [0:21] ='{32'h8b1f03e9,
32'h8b1f03ea,
32'h8b1e03de,
32'h8b0403cb,
32'hf800012a,
32'h8b01014a,
32'h8b080129,
32'hcb01016b,
32'hb400004b,
32'hb4ffff7f,
32'h8b1f03e9,
32'h8b1f03ea,
32'h8b0303cb,
32'h8a0e03ee,
32'hf84001c9,
32'h8b09014a,
32'h8b0801ce,
32'hcb01016b,
32'hb400004b,
32'hb4ffff7f,
32'hf80001ca,
32'hb400001f};
			end
		always_comb
			begin
				q = ROM[addr];
			end
endmodule