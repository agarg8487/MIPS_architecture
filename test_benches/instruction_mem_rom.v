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
            0 : instruction = 32'b00000000000000000000000000100010;
            1 : instruction = 32'b00100000000000010000000000000001;
            2 : instruction = 32'b00000000000000010001000000100000;
            3 : instruction = 32'b00100000000001010000000000000101;
            4 : instruction = 32'b00100000000001100000000000000001;
            5 : instruction = 32'b00000000010000010001100000100000;
            6 : instruction = 32'b00000000000000100000100000100000;
            7 : instruction = 32'b00000000000000110001000000100000;
            8 : instruction = 32'b00000000101001100010000000100010;
            9 : instruction = 32'b00000000100000000010100000100000;
            10 : instruction = 32'b00010000100000000000000000000001;
            11 : instruction = 32'b00001000000000000000000000000101;
            12 : instruction = 32'b00001000000000000000000000001100;
            default : instruction = 0;
        endcase
    end
    assign mem_end = (address > 12) ? 1'b1 : 1'b0;//-----------------------------------------------------------------------
endmodule
