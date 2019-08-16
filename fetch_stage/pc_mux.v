/* 
Authors : Adtiya Terkar, 16EC01003, IIT Bhubaneswar
Aim : PC mux implementation
*/
//////////////////////////////////////////////////////////////////////////////////////////
//project includes
/////////////////////////////////////////////////////////////////////////////////////////

module mod_pc_mux (input mux_control,
                   input [31 : 0] pc_plus_4,
                   input [31 : 0] branch_address,
                   output reg [31 : 0] next_address
                  );

//-------------------------hardware action-------------------------------
    always @(*) begin
        if(mux_contol == 1'b1) next_address <= branch_address;
        else next_address <= pc_plus_4;
    end
//-----------------------------------------------------------------------
endmodule