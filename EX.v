module EX (PCout,dataWrMem,destinoWrOut,zeroOut,alu_out,RegWriteOut,MemtoRegOut,MemWriteOut,BranchOut,RegWriteIn,MemtoRegIn,MemWriteIn,BranchIn,funct,ALUsrc,dato1,dato2,destinoWrIn,inm_ext,jump,negar,mbs,PCin);

//entradas de datos:
input [31:0] dato1,dato2,inm_ext,PCin;

//n� de registro de escritura:
input [3:0] destinoWrIn;
output [3:0] destinoWrOut; 

//entradas de control:
input negar,mbs,jump,RegWriteIn,MemtoRegIn,MemWriteIn,BranchIn,ALUsrc;
input [2:0] funct;

//salidas de control:
output RegWriteOut,MemtoRegOut,MemWriteOut,BranchOut;

//salidas de datos:
output zeroOut;
output [31:0] alu_out,dataWrMem,PCout;
wire zero;

ALU alu (
.alu_out(alu_out), 
.zero(zero), 
.funct(funct), 
.data1(MemWriteIn?dato2:dato1), 
.data2(ALUsrc?inm_ext:dato2));

assign PCout=jump?(ALUsrc?(dato1+inm_ext):inm_ext):(PCin+inm_ext); // si el primer bit del opcode es 1 el salto es incondicional, si adem�s rsSource es 1 entonces la direcci�n se pasa como inmediato+contenido_de_registro

assign dataWrMem=dato1; //si la orden es sw ya se encargar� de activar la escritura en la memoria de datos, sino el valor de esta se�al es irrelevante

assign RegWriteOut=RegWriteIn;
assign MemtoRegOut=MemtoRegIn;
assign MemWriteOut=MemWriteIn;
assign BranchOut=BranchIn;
assign destinoWrOut=destinoWrIn;
assign zeroOut=mbs?(zero?~zero:(negar?~mbs:mbs)):(negar?~zero:zero);

endmodule