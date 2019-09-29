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

module mod_mock_instruction_mem (   
                                    //input ports
                                    input [32 : 0] address,

                                    //output ports
                                    output reg [32 : 0] instruction
                                );
//----------------------------parameters---------------------------------
    reg [32 : 0] rgf_mem [0 : `ins_mem_size] ;
    integer i;
//-----------------------------------------------------------------------
//-------------------------module instantiation--------------------------
//-----------------------------------------------------------------------
//-------------------------hardware action-------------------------------
    initial begin
        for (i = 0; i < (`ins_mem_size + 1); i = i + 1) begin
            rgf_mem[i] = $random;
        end
    end

    always @(*) begin
        instruction = rgf_mem[address];
    end
//-----------------------------------------------------------------------
//----------------------functions and tasks------------------------------
//-----------------------------------------------------------------------
//endmodule