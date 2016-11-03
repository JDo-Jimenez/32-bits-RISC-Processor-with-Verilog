`timescale 1 ns / 1 ps


module RISC_tb  ; 
 
	reg    NReset,clk; 
	wire   MemWriteInMEM,escribir,PCsrc;
	wire 	[31:0] alu_outMEM,WriteDataInMEM,datoMemOut,InstruccionIn,PCinIF,result,PCoutMEM; 
	wire 	[3:0] destinoWrWB;
  
  RISC RISC(
		.destinoWrWB(destinoWrWB),
		.escribir(escribir),
		.PCsrc(PCsrc),
		.result(result),
		.PCoutMEM(PCoutMEM),
      .NReset (NReset),
      .clk (clk),
		.alu_outMEM(alu_outMEM), 
		.MemWriteInMEM(MemWriteInMEM), 
		.WriteDataInMEM(WriteDataInMEM), 
		.datoMemOut(datoMemOut),
		.InstruccionIn (InstruccionIn) ,
		.PCinIF (PCinIF)); 
		
   progmem Mem_Prog ( 
		.dataout (InstruccionIn) ,
		.addr (PCinIF));
  			
   datamem mem_datos (
		.addr(alu_outMEM), 
		.write(MemWriteInMEM), 
		.datain(WriteDataInMEM), 
		.dataout(datoMemOut)); 
  
initial
begin
  clk=0;
  NReset=0;
  #20 NReset=1;
  #85 NReset=0;
  #10 NReset=1;
end

always #10
begin
	clk=~clk;
end
	
endmodule

