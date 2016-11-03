module WB (RegWriteOut,destinoWrOut,res,data_mem,alu_out,destinoWrIn,RegWriteIn,MemtoRegIn);
  input [31:0] alu_out,data_mem;
  input RegWriteIn,MemtoRegIn;
  input [3:0] destinoWrIn;
  output RegWriteOut;
  output [31:0] res;
  output [3:0] destinoWrOut;
  
  
  assign RegWriteOut=RegWriteIn;
  assign destinoWrOut=destinoWrIn;
  assign res=MemtoRegIn?data_mem:alu_out;
  
endmodule
