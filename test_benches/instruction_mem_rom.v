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
            12 : instruction = 32'b00001100000000010000000000000001;
            13 : instruction = 32'b00001100000000100000000000000010;
            14 : instruction = 32'b00001100000000110000000000000011;
            15 : instruction = 32'b00001100000001000000000000000100;
            16 : instruction = 32'b00001100000001010000000000000101;
            17 : instruction = 32'b00001100000001100000000000000110;
            18 : instruction = 32'b00001100000001110000000000000111;
            19 : instruction = 32'b00001100000010000000000000001000;
            20 : instruction = 32'b00001100000010010000000000001001;
            21 : instruction = 32'b00001100000010100000000000001010;
            22 : instruction = 32'b00001100000010110000000000001011;
            23 : instruction = 32'b00001100000011000000000000001100;
            24 : instruction = 32'b00001100000011010000000000001101;
            25 : instruction = 32'b00001100000011100000000000001110;
            26 : instruction = 32'b00001100000011110000000000001111;
            27 : instruction = 32'b00001100000100000000000000010000;
            28 : instruction = 32'b00001100000100010000000000010001;
            29 : instruction = 32'b00001100000100100000000000010010;
            30 : instruction = 32'b00001100000100110000000000010011;
            31 : instruction = 32'b00001100000101000000000000010100;
            32 : instruction = 32'b00001100000101010000000000010101;
            33 : instruction = 32'b00001100000101100000000000010110;
            34 : instruction = 32'b00001100000101110000000000010111;
            35 : instruction = 32'b00001100000110000000000000011000;
            36 : instruction = 32'b00001100000110010000000000011001;
            37 : instruction = 32'b00001100000110100000000000011010;
            38 : instruction = 32'b00001100000110110000000000011011;
            39 : instruction = 32'b00001100000111000000000000011100;
            40 : instruction = 32'b00001100000111010000000000011101;
            41 : instruction = 32'b00001100000111100000000000011110;
            42 : instruction = 32'b00001100000111110000000000011111;
            43 : instruction = 32'b00001100000000110000000000100000;
            default : instruction = 0;
        endcase
    end
    assign mem_end = (address > 43) ? 1'b1 : 1'b0;//-----------------------------------------------------------------------
endmodule
