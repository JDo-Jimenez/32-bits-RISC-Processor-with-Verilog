module IF (PCout,PCin); //Todas las entradas y salidas son puramente combinacionales
  input [31:0] PCin;
  output reg [31:0] PCout; 


  always @PCin
  begin
    PCout=PCin+1;
  end
  
endmodule
