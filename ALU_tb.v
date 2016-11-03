`timescale 1 ns / 1 ps


module ALU_tb  ; 
 
  integer i;
  reg  [31:0]  data2   ; 
  reg  [2:0]  funct   ; 
  wire    zero   ; 
  wire  [31:0]  alu_out   ; 
  reg  [31:0]  data1   ; 
  ALU  alu_bench  ( 
       .data2 (data2 ) ,
      .funct (funct ) ,
      .zero (zero ) ,
      .alu_out (alu_out ) ,
      .data1 (data1 ) ); 

initial
begin

  data2=32'b10101010101010101010101010101111100001;
  funct=3'b111;
  for (i=0;i<8;i=i+1)
  begin
    #1 funct=funct+1;
    #1 data1=data1+32'b10110010101001100;
    #1 data2=data2+8'h0000A310;
  end
    #1 data2=data1;
    #1 funct=010;
    for (i=0;i<4;i=i+1) 
      #1 funct=funct+1;
    #1 data1=32'b01111111111111111111111111111111;data2=32'b01111111111111111111111111111111;funct=3'b001;
end

endmodule

