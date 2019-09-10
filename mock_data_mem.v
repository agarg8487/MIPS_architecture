`define data_mem_size 32
module data_memory  
 (  
      input                         clk,  
      // address input, shared by read and write port  
      input     [31:0]               mem_access_addr,  
      // write port  
      input     [31:0]               mem_write_data,  
      input                         mem_write_en,  
      input mem_read_en,  
      // read port  
      output  wire[31:0]               mem_read_data  
 );  
      integer i;  
      reg [31:0] ram [0:`data_mem_size];  
      initial begin  
           for(i=0;i<=`data_mem_size;i=i+1)  
                ram[i] <= 32'b0;  
      end  
      always @(posedge clk) begin  
           if (mem_write_en)  
                ram[mem_access_addr] <= mem_write_data;  
      end  
      assign mem_read_data = (mem_read_en==1'b1) ? ram[mem_access_addr]: 32'b0;   
 endmodule  