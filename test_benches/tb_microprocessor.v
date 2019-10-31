/* 
Authors : Adtiya Terkar, 16EC01003, IIT Bhubaneswar
Aim : A instruction provider
*/ 
//////////////////////////////////////////////////////////////////////////////////////////
//project includes
`include "instruction_mem_rom.v"
`include "mock_data_mem.v"
`include "../core/mips_processor.v"

//---------mips_processor includes------------
`include "../core/register_file.v"
`include "../core/write_reg_mux.v"
`include "../core/alu_b_mux.v"
`include "../core/pc_mux.v"
`include "../core/write_data_mux.v"
`include "../core/alu_unit.v"
`include "../core/instruction_defines.v"
`include "../core/control_unit.v"
//--------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////

module tb_microprocessor();
//----------------------------parameters---------------------------------
reg clk;
//-----------------------------------------------------------------------
//-------------------------module instantiation--------------------------
//-----------------------------------------------------------------------
//-------------------------hardware action-------------------------------
    initial begin 
        clk = 0; 
        forever #5 clk = ~clk;
    end
//-----------------------------------------------------------------------
//----------------------functions and tasks------------------------------
//-----------------------------------------------------------------------    
endmodule
