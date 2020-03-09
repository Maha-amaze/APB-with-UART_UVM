

module apb_uart(PRESETn,PCLK,PWRITE,PSELx,PENABLE,PWDATA,PADDR,uart_wr,data_out);

  input PRESETn,PCLK,PWRITE;
  input PSELx,PENABLE;
  input [7:0]PWDATA;                 
  input [3:0]PADDR;                  
  wire  [7:0]PRDATA;
  wire  PREADY;
  input uart_wr;
  output [7:0]data_out;

apb_slave a1  (PRESETn,PCLK,PWRITE,PSELx,PENABLE,PWDATA,PADDR,PRDATA,PREADY);
UART a2(PRDATA,PCLK,PRESETn,uart_wr,data_out);

endmodule

