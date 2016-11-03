`timescale 1ns / 1ps

module gen_clk (CLK);
	output reg CLK;
	
	always
	begin 
	 CLK=0;
	 #10 CLK=1;
	 #10;
	end
  
endmodule
