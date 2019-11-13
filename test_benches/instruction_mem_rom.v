/* 
Authors : Adtiya Terkar, 16EC01003, IIT Bhubaneswar
Aim : A instruction provider
*/ 
//////////////////////////////////////////////////////////////////////////////////////////
//project includes
/////////////////////////////////////////////////////////////////////////////////////////
module mod_instruction_mem_rom (
    //input ports
    input [29 : 0] address,
    //output ports
    output reg [31 : 0] instruction,
    output wire mem_end);

//-------------------------hardware action-------------------------------
    always @(*) begin
        case (address)
            0 : instruction = 32'b00100000000000010000000000001101;
            default : instruction = 0;
        endcase
    end
    assign mem_end = (address > 0) ? 1'b1 : 1'b0;//-----------------------------------------------------------------------
endmodule
