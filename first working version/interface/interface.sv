interface apb_if(input bit clk);
  
	logic PRESETn;
	logic PCLK;
	logic PWRITE;
	logic PSEL;
	logic PENABLE;
	logic [7:0] PWDATA; 
	logic [3:0] PADDR;
	logic [7:0] PRDATA;
 	logic PREADY;
  	logic uart_wr;
  	logic [7:0]data_out;

  
endinterface
