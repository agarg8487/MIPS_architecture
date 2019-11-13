//author : Aditya Terkar, 16EC01003, IIT Bhubaneswar
//aim : data memory
`define data_mem_size 64
module mod_data_mem (
    
    input [31 : 0] data_address_1,
    input [31 : 0] write_data,
    input mem_read,
    input mem_write,
    input [31 : 0] data_address_2,
    input reset,
    input clk,
/////////////////////////comment out for synthesis/////////////////////////
    input dump_mem,
/////////////////////////comment out for synthesis/////////////////////////

    output [31 : 0] data_out_1,
    output [31 : 0] data_out_2
);

//----------------------------parameters---------------------------------
    reg [31 : 0] rgf_data_ram [0 : (`data_mem_size - 1)];
    integer i, result_file;
//-----------------------------------------------------------------------
//-------------------------module instantiation--------------------------
//-----------------------------------------------------------------------
//-------------------------hardware action-------------------------------

/////////////////////////comment out for synthesis///////////////////////// 
    initial result_file = $fopen("../common_dump/data_memory_result.txt");
/////////////////////////comment out for synthesis/////////////////////////
    always @(posedge clk) begin
        if(reset) begin
            for(i = 0; i < `data_mem_size; i = i + 1) begin
                rgf_data_ram[i] <= 0;
            end
        end
        else if(mem_write) rgf_data_ram[data_address_1] <= write_data;
    end
    
    assign data_out_1 = (mem_read) ? (rgf_data_ram[data_address_1]) : 32'h00000000;
    assign data_out_2 = rgf_data_ram[data_address_2];

/////////////////////////comment out for synthesis/////////////////////////
    always@(posedge dump_mem) 
      begin
           $display("---dumping all the values stored in data memory---");
          for (i = 0; i < `data_mem_size; i = i + 1) begin
            $fdisplay(result_file, rgf_data_ram[i]);//removed %d
           // $display("register %d - %d", i, rgf_mem[i]);
          end
      end 
/////////////////////////comment out for synthesis/////////////////////////
//-----------------------------------------------------------------------
//----------------------functions and tasks------------------------------
//-----------------------------------------------------------------------

endmodule