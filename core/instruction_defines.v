/* include the header in all
Authors : Adtiya Terkar, 16EC01003, IIT Bhubaneswar
Aim : constants that are to be used in instruction decoding
*/
/////////////////////instruction formats/////////////////////////
//R - instruction format
//--------------------------------------------------------------
//|31-opcode-26|25-rs-21|20-rt-16|15-rd-11|10-shamt-6|5-funct-0|
//--------------------------------------------------------------
//I - instruction format 
//-----------------------------------------------
//|31-opcode-26|25-rs-21|20-rt-16|15-immediate-0|
//-----------------------------------------------
//B - instruction format 
//-----------------------------------------------
//|31-opcode-26|25-rs-21|20-rt-16|15-immediate-0|
//-----------------------------------------------
//J - instruction format
//----------------------------------
//|31-opcode-26|25-target_address-0|
//----------------------------------
/////////////////////////////////////////////////////////////////
///////////////////////opcodes///////////////////////////////////
`define r_opcode   6'b000000
`define lw_opcode  6'b000001
`define j_opcode   6'b000010
`define sw_opcode  6'b000011
`define beq_opcode 6'b000100

/////////////////////////////////////////////////////////////////
//////////////////////funct//////////////////////////////////////
`define funct_add 6'b100000
`define funct_sub 6'b100010
`define funct_and 6'b100100
`define funct_or  6'b100101
`define funct_slt 6'b101010
/////////////////////////////////////////////////////////////////
///////////////////////rs,rt,rd//////////////////////////////////
`define r0 5'b00000
`define r1 5'b00001
`define r2 5'b00001
`define r3 5'b00011
`define r4 5'b00100
`define r5 5'b00101
`define r6 5'b00110
`define r7 5'b00111
`define r8 5'b01000
`define r9 5'b01001
`define r10 5'b01010
`define r11 5'b01011
`define r12 5'b01100
`define r13 5'b01101
`define r14 5'b01110
`define r15 5'b01111
`define r16 5'b10000
`define r17 5'b10001
`define r18 5'b10001
`define r19 5'b10011
`define r20 5'b10100
`define r21 5'b10101
`define r22 5'b10110
`define r23 5'b10111
`define r24 5'b11000
`define r25 5'b11001
`define r26 5'b11010
`define r27 5'b11011
`define r28 5'b11100
`define r29 5'b11101
`define r30 5'b11110
`define r31 5'b11111
/////////////////////////////////////////////////////////////////