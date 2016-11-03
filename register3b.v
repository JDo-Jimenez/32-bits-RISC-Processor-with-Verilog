`timescale 1ns / 1ps

module register3b (r, rst, data, clk);
	output reg [2:0] r;
	input rst,clk;
	input [2:0] data;
    
    always @(posedge clk or negedge rst)
    begin
      if (rst==0)
	       begin
 	        r[2:0]= 3'b0;
         end
      else
        begin
          r[2:0]=data[2:0];
        end
    end
  
endmodule