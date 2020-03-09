import uvm_pkg::*;
`include "uvm_macros.svh"

class apb_driver extends uvm_driver #(apb_seq_item);

   virtual apb_if vif;
  `uvm_component_utils(apb_driver)
   apb_seq_item apb_transactor= new("");
    
    function new (string name, uvm_component parent);
    super.new(name, parent);
    endfunction : new

  //--------------------------------------- 
  // build phase
  //---------------------------------------
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
  `uvm_error("build_phase","config_db-Unable to get intf_vi");
  endfunction: build_phase



  //---------------------------------------  
  // run phase
  //---------------------------------------  
    task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(apb_transactor);
      drive();
      seq_item_port.item_done();
    end
  endtask : run_phase
  
  //---------------------------------------
  // drive - transaction level to signal level
  // drives the value's from seq_item to interface signals
  //---------------------------------------
    task drive();
    vif.PSEL  <= 1;
    vif.PWRITE <= 0;
    //@(posedge vif.DRIVER.clk);
    
    vif.PADDR <= apb_transactor.PADDR;
    
       if(vif.PWRITE==1) begin // write operation
      vif.PWRITE <= apb_transactor.PWRITE;
      vif.PWDATA <= apb_transactor.PWDATA;
      //@(posedge vif.DRIVER.clk);
    end
    else begin //read operation
      vif.PRDATA=apb_transactor.PRDATA;
       //@(posedge vif.DRIVER.clk);
      apb_transactor.PRDATA = vif.PRDATA;
    end*/
    
  endtask : drive
endclass : apb_driver






























