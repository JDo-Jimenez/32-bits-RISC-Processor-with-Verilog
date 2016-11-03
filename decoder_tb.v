`timescale 1 ns / 1 ps


module decoder_tb  ; 
  integer i=0;
  wire  [1:0]  tipo   ; 
  wire  MemtoReg   ; 
  wire  [2:0]  functout   ; 
  wire  RegWrite   ; 
  reg  [3:0]  opcode   ; 
  wire  rsSource   ; 
  wire  ALUsrc   ; 
  wire  Branch   ; 
  wire  MemWrite   ; 
  reg  [2:0]  functin   ; 
  decoder  decodificador  ( 
       .tipo (tipo ) ,
      .MemtoReg (MemtoReg ) ,
      .functout (functout ) ,
      .RegWrite (RegWrite ) ,
      .opcode (opcode ) ,
      .rsSource (rsSource ) ,
      .ALUsrc (ALUsrc ) ,
      .Branch (Branch ) ,
      .MemWrite (MemWrite ) ,
      .functin (functin ) ); 

initial
begin
     functin=3'b000;
  #1 opcode=4'b0000;
  for (i=0;i<16;i=i+1)
  begin
    #1 functin=functin+1;
    #1 functin=functin+1;
    #1 functin=functin+1;
    #1 functin=functin+1;
    #1 functin=functin+1;
    #1 functin=functin+1;
    #1 functin=functin+1;
    #1 functin=0;
    #1 opcode=opcode+1;
  end
end
endmodule

