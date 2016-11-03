module MEM (PCout,alu_outWB,PCsrc,RegWriteOut,MemtoRegOut,destinoWrOut,zero,alu_outMEM,destinoWrIn,RegWriteIn,MemtoRegIn,BranchIn,PCin,jump);
  input jump,zero,RegWriteIn,MemtoRegIn,BranchIn;
  input [31:0] alu_outMEM,PCin;
  input [3:0] destinoWrIn;
  output RegWriteOut,MemtoRegOut,PCsrc;
  output [3:0] destinoWrOut;
  output [31:0] PCout,alu_outWB;
 
  assign alu_outWB=alu_outMEM;
  assign PCout=jump?alu_outMEM:PCin;
  assign PCsrc=jump?BranchIn:(BranchIn&zero);
  assign RegWriteOut=RegWriteIn;
  assign MemtoRegOut=MemtoRegIn;
  assign destinoWrOut=destinoWrIn;
  
endmodule
