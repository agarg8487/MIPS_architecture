/* 
Authors : Aditya Terkar, 16EC01003, IIT Bhubaneswar
Aim : 
*/
//////////////////////////////////////////////////////////////////////////////////////////
/**/
//project includes
`include "register_file.v"
`include "write_reg_mux.v"
`include "alu_b_mux.v"
`include "pc_mux.v"
`include  "write_data_mux.v"
/**/
/////////////////////////////////////////////////////////////////////////////////////////

module mod_mips_processor ( 
                            //input ports
                            input [31 : 0] instruction,
                            input [31 : 0] data,
                            input clk,
                            input reset,
                            //output ports
                            output reg [31 : 0] rg_pc,
                            output wire [31 : 0] data_address
                          );
//----------------------------parameters---------------------------------
    //internal wires
    wire [31 : 0] wr_next_pc;
    wire [31 : 0] wr_pc_plus_4;
    wire [31 : 0] wr_jump_address;
    wire [31 : 0] wr_branch_address;
    wire [31 : 0] wr_se_ins_15_0;
    wire [31 : 0] wr_se_sh2_ins_15_0;

    //write_reg_mux wires
    wire wr_reg_dst; //CONTROL LINE

    //register_file wires
    wire [4 : 0] wr_write_address;
    wire [31 : 0] wr_write_data;
    wire wr_rgf_reset;
    wire wr_rgf_write;
    wire [31 : 0] wr_read_data_1;
    wire [31 : 0] wr_read_data_2;

    //alu_b_mux wires
    wire wr_alu_src; //CONTROL LINE
    wire [31 : 0] wr_alu_b;

    //pc_mux wires
    wire wr_alu_zero; //ALU LINE
    wire wr_branch; //CONTROL LINE
    wire wr_jump; //CONTROL LINE

    //write_data_mux wires
    wire [31 : 0] wr_alu_data; //ALU LINE
    wire wr_mem_to_reg; //CONTROL LINE
//-----------------------------------------------------------------------
//-------------------------module instantiation--------------------------
    mod_register_file register_file ( 
                                        //input ports
                                        .write_address(wr_write_address),
                                        .write_data(wr_write_data),
                                        .read_address_1(instruction[25 : 21]),
                                        .read_address_2(instruction[20 : 16]),

                                        .clk(clk),
                                        .reset(wr_rgf_reset),
                                        .write(wr_rgf_write),

                                        //output ports
                                        .read_data_1(wr_read_data_1),
                                        .read_data_2(wr_read_data_2)
                                    );
    
    mod_write_reg_mux write_reg_mux (   
                                        //input ports
                                        .ins_20_16(instruction[20 : 16]),
                                        .ins_15_11(instruction[15 : 11]),
                                        .reg_dst(wr_reg_dst),

                                        //output ports
                                        .write_reg_add(wr_write_address)
                                    );

    mod_alu_b_mux alu_b_mux         (   
                                        //input ports
                                        .rs2_data(wr_read_data_2),
                                        .immediate(wr_se_ins_15_0),
                                        .alu_src(wr_alu_src),

                                        //output ports
                                        .alu_b(wr_alu_b)
                                    );

    mod_pc_mux pc_mux               ( 
                                        //input ports
                                        .branch(wr_branch),
                                        .jump(wr_jump),
                                        .alu_zero(wr_alu_zero),

                                        .pc_plus_4(wr_pc_plus_4),
                                        .branch_address(wr_branch_address),
                                        .jump_address(wr_jump_address),

                                        //output ports
                                        .next_pc(wr_next_pc)
                                    );
    mod_write_data_mux write_data_mux (
                                        //input ports
                                        .ext_mem_data(data),
                                        .alu_data(wr_alu_data),
                                        .mem_to_reg(wr_mem_to_reg),

                                        //output ports
                                        .write_data(wr_write_data)
                                    );
//-----------------------------------------------------------------------
//-------------------------hardware action-------------------------------
    //pc + 4
    assign wr_pc_plus_4 = rg_pc + 4;

    //evaluate jump_address
    assign wr_jump_address[31 : 28] = wr_pc_plus_4[31 : 28];
    assign wr_jump_address[27 : 2] = instruction[25 : 0];
    assign wr_jump_address[1 : 0] = 0;
    
    //evaluate branch_address
    assign wr_se_ins_15_0 [14 : 0] = instruction [14 : 0];
    assign wr_se_ins_15_0 [31 : 15] = (instruction[15]) ? {16'hffff, 1'b1} : {17'b0};
    assign wr_se_sh2_ins_15_0 [31 : 2] = wr_se_ins_15_0[29 : 0];
    assign wr_se_sh2_ins_15_0[1 : 0] = 0;
    assign wr_branch_address = wr_pc_plus_4 + wr_se_sh2_ins_15_0;
//-----------------------------------------------------------------------
//----------------------functions and tasks------------------------------
//-----------------------------------------------------------------------
endmodule