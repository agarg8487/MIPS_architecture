/* 
Authors : Adtiya Terkar, 16EC01003, IIT Bhubaneswar
Aim : PC mux implementation
*/
//////////////////////////////////////////////////////////////////////////////////////////
//project includes
/////////////////////////////////////////////////////////////////////////////////////////

module mod_pc_mux (
                    //input ports
                    input wire branch,
                    input wire jump,
                    input wire alu_zero,
                    input [31 : 0] pc_plus_4,
                    input [31 : 0] jump_address,
                    input [31 : 0] branch_address,

                    //output ports
                    output reg [31 : 0] next_pc
                  );

//----------------------------parameters---------------------------------
    wire wr_and_brch_aluz;
    wire [1 : 0] wr_condition; 
//-----------------------------------------------------------------------
//-------------------------module instantiation--------------------------
//-----------------------------------------------------------------------
//-------------------------hardware action-------------------------------
    assign wr_and_brch_aluz = (alu_zero & branch);
    assign wr_condition = {wr_and_brch_aluz, jump};

    always @(*) begin
        case (wr_condition) 
            2'b01, 2'b11 : next_pc =  jump_address;
            2'b10 : next_pc = branch_address;
            default : next_pc = pc_plus_4;
        endcase
    end
//-----------------------------------------------------------------------
//----------------------functions and tasks------------------------------
//-----------------------------------------------------------------------
endmodule