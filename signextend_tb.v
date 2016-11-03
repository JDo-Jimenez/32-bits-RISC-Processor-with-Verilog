`timescale 1 ns / 1 ps

module signextend_tb  ; 
 
  reg  [1:0] tipo; 
  wire [31:0]  salida; 
  reg [27:0]  entrada; 
signextend extensor( 
      .tipo (tipo) ,
      .salida (salida) ,
      .entrada (entrada)); 

initial
begin
  tipo=00;
  entrada=28'b0;
  #1 entrada=28'bXXXXXXXXXXX10111111101010100;
  #1 entrada=28'bXXXXXXXXXXX01000000010101011;  
  #1 tipo=01;
  #1 entrada=28'bXXXXXXXX10111111111101010100;
  #1 entrada=28'bXXXXXXXX01000000000010101011;
  #1 tipo=10;
  #1 entrada=28'bXXXX101111111111101010111001;
  #1 entrada=28'bXXXX010000000001010101011001;
  #1 tipo=11;
  #1 entrada=28'b1011101110111111111101010100;
  #1 entrada=28'b0100010001000000000010101011;
end 

endmodule

