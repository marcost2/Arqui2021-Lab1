module maindec (input logic [10:0] Op,
					 output logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,
					 output logic [1:0] ALUOp);
		always_comb
		begin
			casez(Op)
			11'b100_0101_1000,11'b110_0101_1000,11'b100_0101_0000,11'b101_0101_0000: begin
				{ Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp } = 9'b000100010;
			end
			11'b111_1100_0010 : { Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp } = 9'b011110000;
			11'b111_1100_0000 : { Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp } = 9'b110001000;
			11'b101_1010_0??? : { Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp } = 9'b100000101;
			default: { Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp } = 9'b0;
			endcase
		end
endmodule