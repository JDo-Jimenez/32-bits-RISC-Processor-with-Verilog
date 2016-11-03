module signextend (entrada,salida,tipo);
  input [27:0] entrada;
  input [1:0] tipo;
  output reg [31:0] salida;
  
  always @(entrada,tipo)  //Si cambia el tipo antes de que la entrada sea de la longitud correcta tendr� como resultado 
  begin                   //un valor desconocido, pero damos por hecho que cuando guarde en el registro del final de la 
								  //fase, la longitud ya ser� correcta...
    case (tipo)
      2'b00:  //tipo 00 indica un inmediato de 17 bits
			salida=entrada[16]?{15'b111111111111111,entrada[16:0]}:{15'b0,entrada[16:0]};
      2'b01:  //tipo 01 indica un inmediato de 20 bits
			salida=entrada[19]?{12'b111111111111,entrada[19:0]}:{12'b0,entrada[19:0]};
      2'b10:  //tipo 10 indica un inmediato de 24 bits
			salida=entrada[23]?{8'b11111111,entrada[23:0]}:{8'b0,entrada[23:0]};
      2'b11:  //tipo 11 indica un inmediato de 28 bits
			salida=entrada[27]?{4'b1111,entrada[27:0]}:{4'b0,entrada[27:0]};
    endcase
  end
  
endmodule