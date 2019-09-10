/* 
Authors : Aditya Terkar, 16EC01003, IIT Bhubaneswar
Aim : 
*/
//////////////////////////////////////////////////////////////////////////////////////////
//project includes
/////////////////////////////////////////////////////////////////////////////////////////
module mod_alu_b_mux (
                        //input ports
                        input [31 : 0] rs2_data,
                        input [31 : 0] immediate,
                        input alu_src,

                        //output ports
                        output wire [31 : 0] alu_b
                    );
//----------------------------parameters---------------------------------
//-----------------------------------------------------------------------
//-------------------------module instantiation--------------------------
//-----------------------------------------------------------------------
//-------------------------hardware action-------------------------------
    assign alu_b = (alu_src) ? immediate : rs2_data;
//-----------------------------------------------------------------------
//----------------------functions and tasks------------------------------
//-----------------------------------------------------------------------
endmodule