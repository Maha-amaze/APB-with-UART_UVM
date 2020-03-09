import uvm_pkg::*;
import agent_pkg::*;


`include "uvm_macros.svh"
`include "interface.sv"
module tb();
  
  reg clk = 0;
  
  apb_if in(clk);
  
  initial begin
    uvm_config_db #(virtual apb_if)::set(null,"*","vif",in);
    
  end
  
  initial begin
    
    run_test("apb_model_test");
    
  end
  
  always #10 clk=~clk;

initial begin
$vcdpluson();
end
 
  
endmodule
