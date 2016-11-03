`timescale 1ns / 1ps

module register4b (r, rst, data, clk);
	output reg [3:0] r;
	input rst,clk;
	input [3:0] data;
    
   always @(posedge clk or negedge rst)
    begin
      if (rst==0)
	       begin
 	        r[3:0]= 4'b0;
         end
      else
        begin
          r[3:0]=data[3:0];
        end
    end
  
endmodule