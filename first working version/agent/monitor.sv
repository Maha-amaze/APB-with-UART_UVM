import uvm_pkg::*;
`include "uvm_macros.svh"

class apb_monitor extends uvm_monitor;
`uvm_component_utils(apb_monitor)
  virtual apb_if vif;
  apb_seq_item transaction_got;

  uvm_analysis_port #(apb_seq_item) aport_port;
  
  //---------------------------------------
  // The following property holds the transaction information currently
  // begin captured (by the collect_address_phase and data_phase methods).
  //---------------------------------------

  uvm_analysis_port #(apb_seq_item) apb_seq_aport;

  

  //---------------------------------------
  // new - constructor
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
    transaction_got = new();
    aport_port = new("aport", this);
  endfunction : new

  //---------------------------------------
  // build_phase - getting the interface handle
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  if(!uvm_config_db #(virtual apb_if)::get(this, "", "vif", vif))
`uvm_error("build_phase","config_db-Unable to get vif");
       
endfunction: build_phase
  
    task run_phase(uvm_phase phase);
    /*forever begin
      @(posedge vif.MONITOR.clk);
      wait(vif.monitor_cb.PWDATA || vif.monitor_cb.PRDATA);
        transaction_got.PADDR = vif.monitor_cb.PADDR;
      if(vif.monitor_cb.PWRITE==1) begin
        transaction_got.PWRITE = vif.monitor_cb.PWRITE;
        transaction_got.PWDATA = vif.monitor_cb.PWDATA;
        
        @(posedge vif.MONITOR.clk);
      end
      if(vif.monitor_cb.PWRITE==0) begin
        transaction_got.PRDATA = vif.monitor_cb.PRDATA;
        //trans_collected.wr_en = 0;
        @(posedge vif.MONITOR.clk);
        @(posedge vif.MONITOR.clk);
        transaction_got.PRDATA = vif.monitor_cb.PRDATA;
      end
	  aport.write(transaction_got);
      end */
  endtask : run_phase

endclass : apb_monitor






















































