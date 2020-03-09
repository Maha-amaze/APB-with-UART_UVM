module apb_slave(PRESETn,PCLK,PWRITE,PSELx,PENABLE,PWDATA,PADDR,PRDATA,PREADY);
  parameter IDLE=2'b00, SETUP=2'b01, ENB=2'b10;
  
  
  input PRESETn,PCLK,PWRITE;
  input PSELx,PENABLE;
  input [7:0]PWDATA;                 
  input [3:0]PADDR;                  
  output reg [7:0]PRDATA;
  output reg PREADY;
  //output PERR;       
  
  reg [1:0]apb_state;
  reg [31:0]mem [0:4];
  
  always @(posedge PCLK or negedge PRESETn)
    begin     
      if(!PRESETn) begin   
        apb_state=2'b00;         
      end  
      else
        case(apb_state)
          IDLE:begin  
            if(PSELx==0 && PENABLE==0)
              apb_state<=IDLE;
            else
              if(PSELx==1 && PENABLE==0)
                apb_state<=SETUP;
            else apb_state<=IDLE;
          end  
          
          SETUP:begin                           // Setup phase
            if(PSELx==1 && PENABLE==1)
              begin apb_state<=ENB;PREADY=1'b0; end  
            else 
              apb_state<=SETUP;
          end     
          
          ENB: begin                           // ACCess Phase
                if(PSELx==1 && PENABLE==0)
                  begin  
                  PREADY<=1'b1;
                  apb_state<=SETUP;
                    if(PWRITE)                     // data transfer
                    mem[PADDR]<=PWDATA;
                    else
                      PRDATA<=mem[PADDR];
                  end       
                  else if(PSELx==0 && PENABLE==0) 
                      begin  
                        PREADY<=1'b1;
                		apb_state<=IDLE;
                      end   
               	  else 
                    begin apb_state<=ENB; PREADY=1'b0; end   
          		end   
        endcase
    end  
endmodule
