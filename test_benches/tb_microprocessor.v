/* 
Authors : Adtiya Terkar, 16EC01003, IIT Bhubaneswar
Aim : A instruction provider
*/ 
//////////////////////////////////////////////////////////////////////////////////////////
//project includes
`include "instruction_mem_rom.v"
`include "data_mem.v"
`include "../core/mips_processor.v"

//---------mips_processor includes------------
`include "../core/instruction_defines.v"
`include "../core/register_file.v"
`include "../core/write_reg_mux.v"
`include "../core/alu_b_mux.v"
`include "../core/pc_mux.v"
`include "../core/write_data_mux.v"
`include "../core/alu_unit.v"
`include "../core/control_unit.v"
//--------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////

module tb_microprocessor();
//----------------------------parameters---------------------------------
    reg clk, reset, hold, dump_all;
    wire wr_mem_read, wr_mem_write, wr_mem_end;
    wire [31 : 0] wr_pc;
    wire [31 : 0] wr_instruction;
    wire [31 : 0] wr_data;
    wire [31 : 0] wr_data_address;
    wire [31 : 0] wr_write_data;
//-----------------------------------------------------------------------
//-------------------------module instantiation--------------------------
    mod_instruction_mem_rom instruction_memory (
        //input ports
        .address(wr_pc[31 : 2]),
        
        //output ports
        .instruction(wr_instruction),
        .mem_end(wr_mem_end)
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
        .rg_pc(wr_pc),
        .data_address(wr_data_address),
        .write_data(wr_write_data),
        .mem_read(wr_mem_read),
        .mem_write(wr_mem_write)
    );

    // data_memory data_mem (
        
    //     //input ports
    //     .clk(clk),
    //     .mem_write_data(wr_write_data),
    //     .mem_access_addr(wr_data_address),
    //     .mem_write_en(wr_mem_write),
    //     .mem_read_en(wr_mem_read),
    //     .dump_mem(wr_mem_end),

    //     //output ports
    //     .mem_read_data(wr_data)
    // );

    mod_data_mem data_mem (
        
        //input ports
        .clk(clk),
        .reset(reset),
        .write_data(wr_write_data),
        .data_address_1(wr_data_address),
        .mem_write(wr_mem_write),
        .mem_read(wr_mem_read),
        .dump_mem(wr_mem_end),

        //output ports
        .data_out_1(wr_data)
    );
//-----------------------------------------------------------------------
//-------------------------hardware action-------------------------------
    
    //initialise all the registers
    initial begin 
        clk = 1'b0; 
        reset = 1'b1; #11; reset = 1'b0;
        hold = 1'b0;
        dump_all = 1'b0;
    end

    //clock of period #10;
    always begin #5; clk = ~clk; end

    /*always @(posedge clk) begin
        $strobe("%b",wr_instruction);
    end*/
    always @(*) begin
        if (wr_mem_end == 1'b1) begin
            hold = 1'b1;
            #100; dump_all = 1'b1;
            #1; 
            $finish;
        end
    end
//-----------------------------------------------------------------------
//----------------------functions and tasks------------------------------
//-----------------------------------------------------------------------    
endmodule
