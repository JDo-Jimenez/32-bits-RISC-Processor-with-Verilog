// Memoria de programa puramente combinacional que s�lo admite lectura una vez cargado el programa

module progmem (addr, dataout);  
	input [31:0] addr;
	output reg [31:0] dataout;
	reg [31:0] memo [30:0];
	
	 initial
	   begin
	    $readmemb("progmem.txt",memo);              //carga de memoria de programa
	   end 
	 
	 always @addr
	   begin
	     dataout[31:0]=memo[addr];  
	   end
  
endmodule

