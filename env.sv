









`include "apb_agent.sv"
`include "apb_scoreboard.sv"

class apb_model_env extends uvm_env;
  
  //---------------------------------------
  // agent and scoreboard instance
  //---------------------------------------
  apb_agent      apb_agnt;
  apb_scoreboard apb_scb;
  
  `uvm_component_utils(apb_model_env)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    apb_agnt = apb_agent::type_id::create("apb_agnt", this);
    apb_scb  = apb_scoreboard::type_id::create("apb_scb", this);
  endfunction : build_phase
  
  //---------------------------------------
  // connect_phase - connecting monitor and scoreboard port
  //---------------------------------------
  function void connect_phase(uvm_phase phase);
    apb_agnt.monitor.aport_port.connect(apb_scb.aport_export);
  endfunction : connect_phase

endclass : apb_model_env


























