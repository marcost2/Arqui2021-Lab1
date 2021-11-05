module execute #(parameter N = 64)    (
													input logic AluSrc,
                                       input logic [3:0] AluControl,
                                       input logic [63:0] PC_E, signImm_E, readData1_E, readData2_E,
                                       output logic [63:0] PCBranch_E, aluResult_E, writeData_E,
                                       output logic zero_E, negative_E, Carry_E, overflow_E, write_flags_E);
            
    logic [N-1:0] Sl2ToAdd, MuxToALU;            // Lineas auxiliares
    mux2     #(N)        MUX            (.d0(readData2_E), .d1(signImm_E), .s(AluSrc), .y(MuxToALU));
    adder #(N)        Add            (.a(Sl2ToAdd), .b(PC_E), .y(PCBranch_E));
    sl2     #(N)        ShiftLeft2    (.a(signImm_E), .y(Sl2ToAdd));
    alu                 ALU            (.a(readData1_E), .b(MuxToALU), .ALUControl(AluControl), .result(aluResult_E), .zero(zero_E), 
	 .negative(negative_E), .Carry(Carry_E), .overflow(overflow_E), .write_flags(write_flags_E));


    assign writeData_E = readData2_E;
endmodule