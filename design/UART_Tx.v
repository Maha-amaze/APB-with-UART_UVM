`timescale 1ns / 1ps
module UART_Tx(data_in,clk,rst,wr,tx);
input [7:0]data_in;
input clk,rst,wr;
output tx;
wire [2:0]count;
wire [10:0]d_temp,data_frame;
//,data_frame1
wire baud_clk,tx_start;
reg [10:0]data_frame1;
//reg [3:0]temp;
integer i;
parameter totalbit=4'b1011;
initial begin 
i=0;
//temp=4'b0; 
end
assign tx_start=(wr==0);
counter n1(clk,rst,tx_start,count);
assign d_temp={1'b0,data_in,^data_in,1'b1};
assign data_frame={d_temp[0],d_temp[1],d_temp[2],d_temp[3],d_temp[4],d_temp[5],d_temp[6],d_temp[7],d_temp[8],d_temp[9],d_temp[10]};
assign baud_clk=(count==3'b111);

//always@(posedge baud_clk)
//begin
//temp=temp+1;
//if(temp>4'b1011)
//data_frame1[0]=1'b1;
//end

always@(posedge baud_clk)
begin
data_frame1=i?(data_frame>>i):data_frame;
i=i+1;
if(i==totalbit)
i=0;
else i=i;
end
//end
//assign data_frame1=(data_frame>>i);
//assign tx=data_frame1[0];
//initial begin data_frame1=data_frame; end
//always@(posedge baud_clk)
//begin
//data_frame1<=(data_frame1>>1);
//end

assign tx=(baud_clk)?data_frame1[0]:tx;
/*always @(posedge baud_clk)
begin
tx=data_frame1[0];
end*/

endmodule
