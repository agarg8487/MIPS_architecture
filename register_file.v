/* 
Authors : Adtiya Terkar, 16EC01003, IIT Bhubaneswar
Aim : A instruction provider
*/
//////////////////////////////////////////////////////////////////////////////////////////
//project includes

/*
project constants list
    ins_mem_size
*/
/////////////////////////////////////////////////////////////////////////////////////////
module mod_register_file (  
                            //input ports
                            input [4 : 0] write_address,
                            input [31 : 0] write_data,

                            input [4 : 0] read_address_1,
                            input [4 : 0] read_address_2,

                            input reset,
                            input write,
                            input clk,

                            //output ports
                            output [31 : 0] read_data_1,
                            output [31 : 0] read_data_2
                        );

//----------------------------parameters---------------------------------
    reg [31 : 0] rgf_mem [0 : 31];
    integer i;
//-----------------------------------------------------------------------
//-------------------------module instantiation--------------------------
//-----------------------------------------------------------------------
//-------------------------hardware action-------------------------------
    always @(posedge clk) begin
        if(reset == 1'b1) begin
            for(i = 0; i < 31; i = i + 1) begin
                rgf_mem[i] <= 0;
            end
        end else begin 
            if (write == 1'b1) begin 
                rgf_mem[write_address] <= write_data;
            end
        end
    end

    always @(*) begin
        if (read_address_1 == 5'b00000) read_data_1 = 32'b0;
        else read_data_1 = rgf_mem[read_address_1];

        if (read_address_2 == 5'b00000) read_data_2 = 32'b0;
        else read_data_2 = rgf_mem[read_address_2];
    end
//-----------------------------------------------------------------------
//----------------------functions and tasks------------------------------
//-----------------------------------------------------------------------
endmodule                    