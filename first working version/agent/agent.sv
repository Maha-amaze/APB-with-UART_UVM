


import uvm_pkg::*;
`include "uvm_macros.svh"

class apb_agent extends uvm_agent;

  apb_driver    driver;
  apb_sequencer sequencer;
  apb_monitor   monitor;

  `uvm_component_utils(apb_agent)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //---------------------------------------
  // build_phase
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor = apb_monitor::type_id::create("monitor", this);      driver    = apb_driver::type_id::create("driver", this);
      sequencer = apb_sequencer::type_id::create("sequencer", this);
    
  endfunction : build_phase
  
function void connect_phase(uvm_phase phase);
         driver.seq_item_port.connect(sequencer.seq_item_export);  endfunction : connect_phase

endclass : apb_agent





























