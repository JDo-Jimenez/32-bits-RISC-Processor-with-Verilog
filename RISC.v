module RISC (destinoWrWB,escribir,PCsrc,result,PCoutMEM,NReset,clk,alu_outMEM,WriteDataInMEM,datoMemOut,InstruccionIn,PCinIF,MemWriteInMEM);
  
  input [31:0] datoMemOut,InstruccionIn;
  input NReset,clk;
	
  output escribir,PCsrc,MemWriteInMEM;
  output [3:0] destinoWrWB;
  output [31:0] result,PCoutMEM,alu_outMEM,PCinIF,WriteDataInMEM;
	
  
  //se�ales generadas en IF
  wire [31:0] InstruccionIn,PCoutIF,PCinIF;
  //se�ales generadas en ID
  wire [31:0] InstruccionOut,inm_extID,PCinID,PCoutID;
  wire [3:0] destinoWrOutID;
  wire mbsID,negarID,jumpID,RegWriteoutID,MemtoRegID,MemWriteID,BranchID,ALUsrcID;
  wire [2:0] functID;
  //se�ales generadas en EX
  wire [31:0] dato1EX,dato2EX,inm_extEX,PCinEX,PCoutEX,dataWrMemEX,alu_outEX;
  wire [3:0] destinoWrInEX,destinoWrOutEX;
  wire [2:0] functEX;
  wire RegWriteOutEX,RegWriteInEX,MemtoRegOutEX,MemtoRegInEX,MemWriteOutEX,MemWriteInEX,BranchOutEX,BranchInEX,ALUsrcEX,zeroEX,jumpEX,negarEX,mbsEX;
  //se�ales generadas en MEM
  wire BranchInMEM,jumpMEM,zeroMEM,MemWriteInMEM,MemWriteOutMEM,RegWriteInMEM,RegWriteOutMEM,MemtoRegInMEM,MemtoRegOutMEM;
  wire [3:0] destinoWrInMEM,destinoWrOutMEM;
  wire [31:0] datoMemOut,PCinMEM,WriteDataInMEM,alu_outWB1;
  //se�ales generadas en WB
  wire [31:0] data_mem,alu_outWB2;
  wire [3:0] destinoWrInWB;
  wire RegWriteInWB,MemtoRegInWB;


  
  IF IF (
  .PCout(PCoutIF),
  .PCin(PCinIF));
  
  ID ID (
  .mbs(mbsID),
  .negar(negarID),
  .jump(jumpID),
  .dato1(dato1EX),
  .dato2(dato2EX),
  .destinoWrOut(destinoWrOutID),
  .inm_ext(inm_extID),
  .RegWriteout(RegWriteoutID),
  .MemtoReg(MemtoRegID),
  .MemWrite(MemWriteID),
  .Branch(BranchID),
  .ALUsrc(ALUsrcID),
  .funct(functID),
  .PCout(PCoutID),
  .Instruccion(InstruccionOut),
  .PCin(PCinID),
  .RegWritein(escribir),
  .dataWr(result),
  .destinoWrIn(destinoWrWB),
  .rst(NReset),
  .clk(clk));
  
  EX EX (
  .PCout(PCoutEX),
  .dataWrMem(dataWrMemEX),
  .destinoWrOut(destinoWrOutEX),
  .zeroOut(zeroEX),
  .alu_out(alu_outEX),
  .RegWriteOut(RegWriteOutEX),
  .MemtoRegOut(MemtoRegOutEX),
  .MemWriteOut(MemWriteOutEX),
  .BranchOut(BranchOutEX),
  .RegWriteIn(RegWriteInEX),
  .MemtoRegIn(MemtoRegInEX),
  .MemWriteIn(MemWriteInEX),
  .BranchIn(BranchInEX),
  .funct(functEX),
  .ALUsrc(ALUsrcEX),
  .dato1(dato1EX),
  .dato2(dato2EX),
  .destinoWrIn(destinoWrInEX),
  .inm_ext(inm_extEX),
  .jump(jumpEX),
  .negar(negarEX),
  .mbs(mbsEX),
  .PCin(PCinEX));

  MEM MEM(
  .PCout(PCoutMEM),
  .alu_outWB(alu_outWB1),
  .PCsrc(PCsrc),
  .RegWriteOut(RegWriteOutMEM),
  .MemtoRegOut(MemtoRegOutMEM),
  .destinoWrOut(destinoWrOutMEM),
  .zero(zeroMEM),
  .alu_outMEM(alu_outMEM),
  .destinoWrIn(destinoWrInMEM),
  .RegWriteIn(RegWriteInMEM),
  .MemtoRegIn(MemtoRegInMEM),
  .BranchIn(BranchInMEM),
  .PCin(PCinMEM),
  .jump(jumpMEM));
  

  
  WB WB(
  .RegWriteOut(escribir),
  .destinoWrOut(destinoWrWB),
  .res(result),
  .data_mem(data_mem),
  .alu_out(alu_outWB2),
  .destinoWrIn(destinoWrInWB),
  .RegWriteIn(RegWriteInWB),
  .MemtoRegIn(MemtoRegInWB));
  
  //Registramos todas las conexiones entre etapas, pues todas las etapas son puramente combinacionales:
  //IF to IF
  
  register32b regPC_IFtoIF(
  .r(PCinIF), 
  .rst(NReset),
  .data(PCsrc?PCoutMEM:PCoutIF), 
  .clk(clk));
  
  
  //IF to ID
  
  register32b regPC_IFtoID(
  .r(PCinID), 
  .rst(NReset),
  .data(PCoutIF), 
  .clk(clk));
  
  register32b regInstr_IFtoID(
  .r(InstruccionOut), 
  .rst(NReset),
  .data(InstruccionIn), 
  .clk(clk));
  
  
  
  //ID to EX
  
  register4b regdestinoWr_IDtoEX(
  .r(destinoWrInEX), 
  .rst(NReset),
  .data(destinoWrOutID), 
  .clk(clk));
  
  register32b regInmediato_IDtoEX(
  .r(inm_extEX), 
  .rst(NReset),
  .data(inm_extID), 
  .clk(clk));
  
  register32b regPC_IDtoEX(
  .r(PCinEX), 
  .rst(NReset),
  .data(PCoutID), 
  .clk(clk));

  register regmbs_IDtoEX(
  .r(mbsEX), 
  .rst(NReset),
  .data(mbsID), 
  .clk(clk));

  register regnegar_IDtoEX(
  .r(negarEX), 
  .rst(NReset),
  .data(negarID), 
  .clk(clk));

  register regjump_IDtoEX(
  .r(jumpEX), 
  .rst(NReset),
  .data(jumpID), 
  .clk(clk));

  register regRegWrite_IDtoEX(
  .r(RegWriteInEX), 
  .rst(NReset),
  .data(RegWriteoutID), 
  .clk(clk));
  
  register regMemtoReg_IDtoEX(
  .r(MemtoRegInEX), 
  .rst(NReset),
  .data(MemtoRegID), 
  .clk(clk));
  
  register regMemWrite_IDtoEX(
  .r(MemWriteInEX), 
  .rst(NReset),
  .data(MemWriteID), 
  .clk(clk));
  
  register regBranch_IDtoEX(
  .r(BranchInEX), 
  .rst(NReset),
  .data(BranchID), 
  .clk(clk));

  register regALUsrc_IDtoEX(
  .r(ALUsrcEX), 
  .rst(NReset),
  .data(ALUsrcID), 
  .clk(clk));

  register3b regfunct_IDtoEX(
  .r(functEX), 
  .rst(NReset),
  .data(functID), 
  .clk(clk));


//EX to MEM

  
  register32b regPC_EXtoMEM(
  .r(PCinMEM), 
  .rst(NReset),
  .data(PCoutEX), 
  .clk(clk));
  
  register32b regdataWrMem_EXtoMEM(
  .r(WriteDataInMEM), 
  .rst(NReset),
  .data(dataWrMemEX), 
  .clk(clk));

  register4b regdestinoWr_EXtoMEM(
  .r(destinoWrInMEM), 
  .rst(NReset),
  .data(destinoWrOutEX), 
  .clk(clk));

  register regJump_EXtoMEM(
  .r(jumpMEM), 
  .rst(NReset),
  .data(jumpEX), 
  .clk(clk));

  register regzero_EXtoMEM(
  .r(zeroMEM), 
  .rst(NReset),
  .data(zeroEX), 
  .clk(clk));

  register regRegWrite_EXtoMEM(
  .r(RegWriteInMEM), 
  .rst(NReset),
  .data(RegWriteOutEX), 
  .clk(clk));
  
  register regMemtoReg_EXtoMEM(
  .r(MemtoRegInMEM), 
  .rst(NReset),
  .data(MemtoRegOutEX), 
  .clk(clk));
  
  register regMemWrite_EXtoMEM(
  .r(MemWriteInMEM), 
  .rst(NReset),
  .data(MemWriteOutEX), 
  .clk(clk));
  
  register regBranch_EXtoMEM(
  .r(BranchInMEM), 
  .rst(NReset),
  .data(BranchOutEX), 
  .clk(clk));
 
  register32b regalu_out_EXtoMEM(
  .r(alu_outMEM), 
  .rst(NReset),
  .data(alu_outEX), 
  .clk(clk));
  
  
  //MEM to WB
  
  register32b regALU_out_MEMtoWB(
  .r(alu_outWB2), 
  .rst(NReset),
  .data(alu_outWB1), 
  .clk(clk));
  
  register32b regData_mem_out_MEMtoWB(
  .r(data_mem), 
  .rst(NReset),
  .data(datoMemOut), 
  .clk(clk));
  
  register regRegWrite_MEMtoWB(
  .r(RegWriteInWB), 
  .rst(NReset),
  .data(RegWriteOutMEM), 
  .clk(clk));

  register regMemtoReg_MEMtoWB(
  .r(MemtoRegInWB), 
  .rst(NReset),
  .data(MemtoRegOutMEM), 
  .clk(clk));
  
  register4b regdestinoWr_MEMtoWB(
  .r(destinoWrInWB), 
  .rst(NReset),
  .data(destinoWrOutMEM), 
  .clk(clk));


  
  
endmodule
