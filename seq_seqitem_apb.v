//Sequence item(aka transaction) class
//----------------------
 
class apb_seq_item extends uvm_sequence_item;
  `uvm_object_utils(apb_seq_item)
  //Input declaration
  
rand bit PRESETn,PCLK,PWRITE;
rand bit PSELx,PENABLE;
rand bit [7:0]PWDATA;        
rand bit [3:0]PADDR;
rand bit uart_wr;   
  //Constructor 
  //--------
  function new(string name="apb_seq_item");
    super.new(name);
  endfunction
  
  //Constraint block
  //-----------------
  constraint c_block {PSELx==1;PENABLE==1;}
  
endclass

//Transaction class ends here

  
  

//Sequence class
//----------------
class apb_model_sequence extends uvm_sequence#(apb_seq_item);
  `uvm_object_utils(apb_model_sequence)
  
  //Constructor
  //--------
  function new(string name="apb_model_sequence");
    super.new(name);
  endfunction
  
  //Body task
  //---------
  task body();
    apb_seq_item txn=new();
    repeat(50) begin
    start_item(txn);
      txn.randomize();
      finish_item(txn);
    end
    
  endtask
endclass
//Sequence class ends here