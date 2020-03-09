//Sequence item(aka transaction) class
//----------------------
import uvm_pkg::*;
`include "uvm_macros.svh"
 
class apb_seq_item extends uvm_sequence_item;
  `uvm_object_utils(apb_seq_item)
  //Input declaration
  
rand bit PRESETn,PCLK,PWRITE;
rand bit PSELx,PENABLE;
rand bit [7:0]PWDATA;        
rand bit [3:0]PADDR;
rand bit uart_wr;   
bit [7:0]PRDATA;

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

  
  


