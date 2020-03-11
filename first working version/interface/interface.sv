interface apb_if(input bit PCLK);
  
	logic PRESETn;
	//logic PCLK;
	logic PWRITE;
	logic PSEL;
	logic PENABLE;
	logic [7:0] PWDATA; 
	logic [3:0] PADDR;
  	logic uart_wr;
  	logic [7:0]data_out;
clocking cb@(posedge PCLK);
        
    output #18ns PSEL,PENABLE,PWDATA,PADDR,uart_wr,PRESETn;
    
  endclocking
  
endinterface
