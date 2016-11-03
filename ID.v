module ID (mbs,negar,jump,dato1,dato2,destinoWrOut,inm_ext,RegWriteout,MemtoReg,MemWrite,Branch,ALUsrc,funct,PCout,Instruccion,PCin,RegWritein,dataWr,destinoWrIn,rst,clk);
  input RegWritein,rst,clk;
  input [3:0] destinoWrIn;
  input [31:0] Instruccion,PCin,dataWr;
  output [31:0] dato1,dato2,inm_ext,PCout;
  output [3:0] destinoWrOut;
  output RegWriteout,MemtoReg,MemWrite,Branch,ALUsrc,mbs,negar;
  output jump; //indica si, de existir un salto, este es incondicional
  output [2:0] funct;
  wire [1:0] tipo;
  
  decoder decodificador (
  .mbs(mbs),
  .negar(negar),
  .functout(funct),
  .RegWrite(RegWriteout),
  .MemtoReg(MemtoReg),
  .MemWrite(MemWrite),
  .Branch(Branch),
  .tipo(tipo),
  .ALUsrc(ALUsrc),
  .opcode(Instruccion[31:28]),
  .functin(Instruccion[19:17]));
  
  bancoreg rs (
  .addrr((Instruccion[31:28]==4'b1110)?Instruccion[27:24]:Instruccion[23:20]),//toma como direccion de registro fuente la correspondiente al campo destino si la orden es sw � salto incondicional a registro+inmediato
  .addrw(destinoWrIn), 
  .write(RegWritein), 
  .datain(dataWr), 
  .dataout(dato1),
  .rst(rst),
  .clk(clk));

  bancoreg rt (
  .addrr(((Instruccion[31:28]==4'b1011)||(~Instruccion[31]))?Instruccion[27:24]:Instruccion[16:13]),
  .addrw(destinoWrIn), 
  .write(RegWritein), 
  .datain(dataWr), 
  .dataout(dato2),
  .rst(rst),
  .clk(clk));
  
  signextend extensor (
  .entrada(Instruccion[27:0]),
  .salida(inm_ext),
  .tipo(tipo));
  
  assign jump=Instruccion[31]; //por como se ha codificado este bit es 1 si el salto es incondicional y 0 si el salto es condicional
  assign destinoWrOut=Instruccion[27:24];
  assign PCout=PCin;

endmodule