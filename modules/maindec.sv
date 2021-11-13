module maindec (input logic [10:0] Op,
					 output logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, condBranch,
					 output logic [1:0] ALUOp);
		always_comb
		begin
			casez(Op)
			//ADD				, SUB			,AND			,ORR				,ADDS            ,SUBS
			11'b100_0101_1000,11'b110_0101_1000,11'b100_0101_0000,11'b101_0101_0000,11'b101_0101_1000,11'b111_0101_1000: 
			begin
				{ Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, condBranch,ALUOp } = 10'b0001000010;
			end
			//LDUR
			11'b111_1100_0010 : { Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, condBranch,ALUOp } = 10'b0111100000;
			//STUR
			11'b111_1100_0000 : { Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, condBranch,ALUOp } = 10'b1100010000;
			//CBZ
			11'b101_1010_0??? : { Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, condBranch,ALUOp } = 10'b1000001001;
			//B.cond
			11'b010_1010_0??? : { Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, condBranch,ALUOp } = 10'b1000000111;
			default: { Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, condBranch,ALUOp } = 10'b0;
			endcase
		end
endmodule