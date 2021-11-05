// Etapa: MEMORY

module memory 	(input logic Branch_M, condBranch_M,zero_M,
					input logic [4:0] bType,
					input logic [3:0] CPSR, //zero_E,negative_E,Carry_E,overflow_E
					output logic PCSrc_M);
	logic condBranch;
	always_comb begin
		casez(bType)
			//EQ
			5'b00000: condBranch = CPSR[3] === 1;
			//NE
			5'b00001: condBranch = CPSR[3] === 0;
			//HS
			5'b00010: condBranch = CPSR[1] === 1;
			//LO
			5'b00011: condBranch = CPSR[1] === 0;
			//MI
			5'b00100: condBranch = CPSR[2] === 1;
			//PL
			5'b00101: condBranch = CPSR[2] === 0;
			//VS
			5'b00110: condBranch = CPSR[0] === 1;
			//VC
			5'b00111: condBranch = CPSR[0] === 0;
			//HI
			5'b01000: condBranch = (CPSR[3] === 0) & (CPSR[1] === 1);
			//LS
			5'b01001: condBranch = ~((CPSR[3] === 0) & (CPSR[1] === 1));
			//GE
			5'b01010: condBranch = CPSR[2] === CPSR[0];
			//LT
			5'b01011: condBranch = CPSR[2] !== CPSR[0];
			//GT
			5'b01100: condBranch = (CPSR[3] === 0) & (CPSR[2] === CPSR[0]);
			//LE
			5'b01101: condBranch = ~((CPSR[3] === 0) & (CPSR[2] === CPSR[0]));
			default: condBranch = 1'b0;
		endcase
	end
	assign PCSrc_M = (Branch_M & zero_M) | condBranch;
	
endmodule