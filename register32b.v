`timescale 1ns / 1ps

module register32b (r, rst, data, clk);
	output reg [31:0] r;
	input rst,clk;
	input [31:0] data;
    
    always @(posedge clk or negedge rst)
    begin
      if (rst==0)
	       begin
 	        r[31:0]= 32'b0;
         end
      else
        begin
          r[31:0]=data[31:0];
        end
    end

endmodule