module signext (input logic [31:0] a,
					 output logic [63:0] y);
	always_comb
	casez(a[31:21])
		//LDUR 
		11'b111_1100_0010: y= { {56{a[20]}}, a[19:12]};
		//STUR
		11'b111_1100_0000: y= {{56{a[20]}}, a[19:12]};		
		//CBZ
		11'b101_1010_0???: y= {{46{a[23]}}, a[22:5]};		
		default:y = 64'b0;
	endcase
endmodule