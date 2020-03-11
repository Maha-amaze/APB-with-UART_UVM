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
     
      finish_item(txn);
    end
    
  endtask
endclass
//Sequence class ends here
