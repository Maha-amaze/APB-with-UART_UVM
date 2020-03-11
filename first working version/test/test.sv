//Test class

//--------

//--------



class apb_model_test extends uvm_test;

  `uvm_component_utils(apb_model_test)

  

  //Declaring objects

  //-------------

  

  apb_model_env apb_model_env_h;

  apb_model_sequence seq_h;

  

  //Constructors

  //---------

  

  function new(string name="apb_model_test",uvm_component parent);

    super.new(name,parent);

  endfunction

  

  //Build phase

  //------------

  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    

    //Creating object of ENV class

    //-------------------------

    

    apb_model_env_h = new("apb_model_env_obj",this);

    seq_h = new("apb_model_seq");

  endfunction

  

  //Run phase

  //--------

  virtual task run_phase(uvm_phase phase);

    phase.raise_objection(this,"Starting Test");

    seq_h.start(apb_model_env_h.apb_agnt.sequencer);

    phase.drop_objection(this);

  endtask
 
endclass
