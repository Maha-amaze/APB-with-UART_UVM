




class apb_scoreboard extends uvm_scoreboard;
  
    apb_seq_item pkt_qu[$];
  
    bit [7:0] sc_apb [4];

  uvm_analysis_port#(apb_seq_item) aport;
  `uvm_component_utils(apb_scoreboard)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      aport = new("aport", this);
      foreach(sc_apb[i]) sc_apb[i] = 8'hFF;
  endfunction: build_phase
  
   function void write(apb_seq_item pkt);//handle creation
    //pkt.print();
    pkt_qu.push_back(pkt);
  endfunction : write

    
   task run_phase(uvm_phase phase);
    apb_seq_item apb_pkt;
    
    forever begin
      wait(pkt_qu.size() > 0);
      apb_pkt = pkt_qu.pop_front();
      
      if(apb_pkt.PWRITE==1) begin
        sc_apb[apb_pkt.PADDR] = apb_pkt.PWDATA;
        `uvm_info(get_type_name(),$sformatf("------ :: WRITE DATA       :: ------"),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Addr: %0h",apb_pkt.PADDR),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Data: %0h",apb_pkt.PWDATA),UVM_LOW)
        `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)        
      end
      else if(apb_pkt.PWRITE==0) begin
        if(sc_apb[apb_pkt.PADDR] == apb_pkt.PRDATA) begin
          `uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match :: ------"),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Addr: %0h",apb_pkt.PADDR),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_apb[apb_pkt.PADDR],apb_pkt.PRDATA),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
        else begin
          `uvm_error(get_type_name(),"------ :: READ DATA MisMatch :: ------")
          `uvm_info(get_type_name(),$sformatf("Addr: %0h",apb_pkt.PADDR),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_apb[apb_pkt.PADDR],apb_pkt.PRDATA),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
      end
    end
  endtask : run_phase
endclass : apb_scoreboard


























class my_scoreboard extends uvm_component;

`uvm_component_utils(my_scoreboard)

uvm_analysis_export #(my_transaction) aport;

function new(string name, uvm_component parent);
super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
super.build_phase(phase);
aport=new("aport,this");
endfunction:build_phase

function void connect_phase (uvm_phase phase);
super.connect_phase(phase);
endfunction:connect_phase

task run_phase(uvm_phase phase);
endtask:run_phase

endclass:my_scoreboard
