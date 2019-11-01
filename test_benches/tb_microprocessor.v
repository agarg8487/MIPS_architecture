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
    reg clk, reset, hold dump_all;
    wire mem_read, mem_write;
    wire [31 : 0] wr_pc;
    wire [31 : 0] wr_instruction;
    wire [31 : 0] wr_data;
    wire [31 : 0] wr_data_address;
//-----------------------------------------------------------------------
//-------------------------module instantiation--------------------------
    mod_instruction_mem_rom instruction_memory (
        .address(wr_pc[31 : 29]),
        .instruction(wr_instruction)
    );
    
    mod_mips_processor dut (
        //input ports
        .instruction(wr_instruction),
        .data(wr_data),
        .clk(clk),
        .reset(reset),
        .hold(hold),

        //testing ports
        .dump_all(dump_all),

        //output ports
        .rg_pc(wr_pc)
        .data_address(wr_data_address),
        .mem_read(wr_mem_read),
        .mem_write(wr_mem_write)
    );
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
