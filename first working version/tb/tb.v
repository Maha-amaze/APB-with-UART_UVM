import uvm_pkg::*;
import agent_pkg::*;


`include "uvm_macros.svh"
`include "interface.sv"
module tb();
  
  reg clk = 0;
  
  apb_if in(clk);

apb_uart u1(
  in.PRESETn,in.PCLK,in.PWRITE,
  in.PSEL, in.PENABLE,
  in.PWDATA,              
  in.PADDR,
  in.uart_wr,
  in.data_out);



  
initial begin in.PRESETn =1;#3 in.PRESETn=0; @(posedge in.PCLK) in.PRESETn=1; end
  initial begin
    uvm_config_db #(virtual apb_if)::set(null,"*","vif",in);
    
  end
initial begin 
in.PSEL<=0;
in.PENABLE<=0;
in.PWRITE<=1;
in.PWDATA<=8'b00111100;
in.PADDR<=4'b0011;
in.uart_wr<=0;
end

initial begin
    $vcdpluson();
    in.uart_wr=0;in.PADDR=0;in.PWDATA=0;
    in.PRESETn = 1;
    fork
      @(posedge clk) begin #2 in.PRESETn=0; end
      
      @(in.cb) begin in.cb.PRESETn<=1;in.cb.PSEL<=1;in.cb.PENABLE<=0; end
      
    join
      
    @(in.cb) begin in.cb.PSEL<=1;in.cb.PENABLE<=1;end
      
    @(in.cb) begin in.cb.PSEL<=1;in.cb.PENABLE<=0;in.cb.uart_wr<=1;in.cb.PADDR<=5;in.cb.PWDATA<=10;end

@(in.cb) begin in.cb.PSEL<=1;in.cb.PENABLE<=1;end

@(in.cb) begin in.cb.PSEL<=1;in.cb.PENABLE<=0;in.cb.uart_wr<=0; end
    
  end


  initial begin
    
    run_test("apb_model_test");
    
  end
  
  always #10 clk=~clk;

initial begin
$vcdpluson();
end
 
  
endmodule
