/* 
Authors : Adtiya Terkar, 16EC01003, IIT Bhubaneswar
Aim : fetch main stage implementation
*/
//////////////////////////////////////////////////////////////////////////////////////////
//project includes
/////////////////////////////////////////////////////////////////////////////////////////
module fetch_main(  
                    //input ports
                    input reset,
                    input hold,
                    input clk,
                    input [32 : 0] instruction,
                    //output ports
                    output reg [32 : 0] rg_instruction,
                    output reg [32 : 0] rg_pc
                );

//-------------------------------parameters-------------------------------------
    wire [32 : 0] wr_pc_next;
//------------------------------------------------------------------------------
//---------------------------module instantiations------------------------------
//------------------------------------------------------------------------------
//-----------------------------hardware action----------------------------------
    assign wr_pc_next = rg_pc + 4;

    //update pc
    always @(posedge clk) begin
        if (reset == 1'b1) rg_pc <= 0;
        else if (hold  == 1'b1) rg_pc <= rg_pc;
        else rg_pc <= wr_pc_next;
    end

    //store the instruction
    always @(posedge clk) begin
        if (reset == 1'b1) rg_instruction <= 0;
        else if (hold  == 1'b1)  rg_instruction <= rg_instruction;
        else rg_instruction <= instruction;
    end
//------------------------------------------------------------------------------
//-------------------------tasks and functions-----------------------------------
//------------------------------------------------------------------------------

endmodule