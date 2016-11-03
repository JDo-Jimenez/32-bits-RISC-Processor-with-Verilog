module bancoreg (addrr, addrw, write, datain, dataout,rst,clk);   // Banco de registros 16x32 con salida y entrada puramente combinacional
	input [3:0] addrr,addrw;
	input write,rst,clk;
	input [31:0] datain;
	output reg [31:0] dataout;
	reg [31:0] memo [15:0];
	//integer i;
	
	 always @(posedge clk or negedge rst)
	   begin
	     if (rst==0)
	       begin
	        // i=0;
	         //while(i<16)                              
	           //begin
	             memo[0]=32'b0;
					 memo[1]=32'b0;
					 memo[2]=32'b0;
					 memo[3]=32'b0;
					 memo[4]=32'b0;
					 memo[5]=32'b0;
					 memo[6]=32'b0;
					 memo[7]=32'b0;
					 memo[8]=32'b0;
					 memo[9]=32'b0;
					 memo[10]=32'b0;
					 memo[11]=32'b0;
					 memo[12]=32'b0;
					 memo[13]=32'b0;
					 memo[14]=32'b0;
					 memo[15]=32'b0;
	            // i=i+1;
	           //end
	       end  
	     else
	       begin 
	         if (write==1) memo[addrw]=datain[31:0];
	         dataout[31:0]=memo[addrr]; //lee a la vez que escribe, para poder ajustar al m�ximo la segmentaci�n 
	       end  
	   end
  
endmodule

