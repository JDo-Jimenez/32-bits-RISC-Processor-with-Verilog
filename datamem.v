 //memoria de datos que tiene a la salida el valor del registro en la posicion addr (si se requiere escribir 
 //la salida ser� el nuevo valor). La memoria es puramente combinacional

module datamem (addr, write, datain, dataout);  
	input [31:0] addr;                         
	input write;
	input [31:0] datain;
	output reg [31:0] dataout;
	reg [31:0] memo [33:0];
	
	initial
	   begin
	    $readmemb("datamem.txt",memo);               //carga de memoria de datos inicial 
	   end 
	 
	 always @(write,datain,addr)
	   begin
	     if (write==1) memo[addr]=datain[31:0];
	     dataout=memo[addr];
	   end
endmodule


