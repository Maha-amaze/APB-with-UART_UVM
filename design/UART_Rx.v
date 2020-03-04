`timescale 1ns / 1ps
module UART_Rx(Rx,clk,rst,wr,data_out);
input Rx,clk,rst,wr;
output reg[7:0]data_out;
reg Rx_start,baud_clk;
reg [2:0]count;
reg [10:0]data_frame; 
initial begin count=3'b000;data_frame=11'b11111111111; end
always@(posedge clk)
begin
if(rst && wr)
Rx_start=1'b1;
else
Rx_start=1'b0;
end

always@(posedge clk) 
begin
if(Rx_start)
begin
count=count+1;
if(count==0)             
baud_clk=1;
else 
baud_clk=0;
end
else
count=0;
end
//
//always@(posedge clk) 
//begin
//&& (count<((count==4'b0111)/2)+7)
//end
//
always@(negedge clk) 
begin
if(baud_clk) begin
data_frame={data_frame[9:0],Rx};
if(data_frame[10]==0) begin
data_out=data_frame[9:2];
data_frame=11'b11111111111;end
else
data_out=data_out; end
else
data_frame=data_frame;
end

//always@(posedge baud_clk )
//begin
//data_frame={data_frame[9:0],Rx};
//if(data_frame[10]==0)
//data_out=data_frame[9:2];
//else
//data_out=data_out;
//end
endmodule

