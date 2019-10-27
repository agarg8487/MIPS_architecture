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
                                    output reg [32 : 0] instruction,
                                    output reg ready
                                );
//----------------------------parameters---------------------------------
    reg [31 : 0] rgf_mem [0 : (`ins_mem_size - 1 )] ;
    integer i;
//-----------------------------------------------------------------------
//-------------------------module instantiation--------------------------
//-----------------------------------------------------------------------
//-------------------------hardware action-------------------------------
    initial begin
        $readmemb("../common_dump/binary_instructions.txt", rgf_mem);
    end

    always @(*) begin
        instruction = rgf_mem[address];
    end
//-----------------------------------------------------------------------
//----------------------functions and tasks------------------------------
//-----------------------------------------------------------------------
//endmodule