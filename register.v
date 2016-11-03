`timescale 1ns / 1ps

module register (r, rst, data, clk);
	output reg r;
	input rst,clk;
	input data;


    always @(posedge clk or negedge rst)
    begin
      if (rst==0)
	       begin
 	        r=0;
         end
      else
        begin
          r=data;
        end
    end
  
endmodule