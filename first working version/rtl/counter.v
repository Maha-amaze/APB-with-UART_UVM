`timescale 1ns / 1ps

module counter #(parameter max_value=7,N=3)(clk,rst,en,count);
  input clk,rst,en;
  output reg [N-1:0]count;
  always @(posedge clk)
    begin
      if(!rst)
        count<=3'b0;
      else if(en)
        begin
          if(count==max_value)
            count<=3'b0;
          else 
            count<=count+1;
        end
      else
        count<=count;
    end
endmodule