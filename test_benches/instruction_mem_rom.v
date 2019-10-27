/* 
Authors : Adtiya Terkar, 16EC01003, IIT Bhubaneswar
Aim : A instruction provider
*/ 
//////////////////////////////////////////////////////////////////////////////////////////
//project includes
/////////////////////////////////////////////////////////////////////////////////////////
module mod_instruction_mem_rom (
    //input ports
    input [31 : 0] address,
    //output ports
    output reg [31 : 0] instruction,
);

//-------------------------hardware action-------------------------------
    always @(*) begin
        case (address)
            0 : instruction = 32'b00000000001000100001100000100000;
            1 : instruction = 32'b00000100100001011111111111111111;
            2 : instruction = 32'b00001000000000000000000000100000;
            default : instruction = 0;
        endcase
    end
//-----------------------------------------------------------------------
endmodule
