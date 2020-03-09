`timescale 1ns / 1ps

module UART(data_in,clk,rst,uart_wr,data_out);
input [7:0]data_in;
input clk,rst,uart_wr;
output [7:0]data_out;
wire Tx,Rx; 
reg temp;
//TxUART_rough n1(rst,clk,data_in,wr,Tx);
UART_Tx u1(data_in,clk,rst,uart_wr,Tx);
always@(negedge clk)
begin
temp=Tx;
end
//assign Rx=(((count==3'b111)/2)+7)?Tx:Rx;
assign Rx=temp;
UART_Rx u2(Rx,clk,rst,~uart_wr,data_out);

endmodule
