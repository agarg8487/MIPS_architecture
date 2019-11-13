import os
import subprocess
#--------------------------------------------------------------------------------------
from simulators import opcode_bin as opb
from simulators import immd_bin as imb
from simulators import reg_bin as rgb
#--------------------------------------------------------------------------------------
def converter(file_name) :
    os.chdir('assembly_codes')
    instruction_list = list()
    with open(file_name,'r') as ins_file :
        for line in ins_file :
            for word in line.split() :
                instruction_list.append(word)

    i = 0
    line_val = 0
    instruction_count = 0
    file_name = ('binary_instructions.txt')
    file_handle = open(file_name,'w+')
    verilog_file = open('instruction_mem_rom.v', 'w+')
    verilog_file.write('/* \n')
    verilog_file.write('Authors : Adtiya Terkar, 16EC01003, IIT Bhubaneswar\n')
    verilog_file.write('Aim : A instruction provider\n')
    verilog_file.write('*/ \n')
    verilog_file.write('//////////////////////////////////////////////////////////////////////////////////////////\n')
    verilog_file.write('//project includes\n')
    verilog_file.write('/////////////////////////////////////////////////////////////////////////////////////////\n')
    verilog_file.write('module mod_instruction_mem_rom (\n')
    verilog_file.write('    //input ports\n')
    verilog_file.write('    input [29 : 0] address,\n')
    verilog_file.write('    //output ports\n')
    verilog_file.write('    output reg [31 : 0] instruction,\n')
    verilog_file.write('    output wire mem_end')
    #verilog_file.write('    output reg ready\n')
    verilog_file.write(');\n\n')
    verilog_file.write('//-------------------------hardware action-------------------------------\n')
    verilog_file.write('    always @(*) begin\n')
    verilog_file.write('        case (address)\n')

    while ( i  < len(instruction_list)) :
        opcode = opb.opcode_bin(instruction_list[i])
        opcode_bin = opcode[0]
        funct_bin = opcode[1]
        op_type = opcode[2]

        if ((op_type == 'r') or (op_type == 'i') or(op_type == 'j') or (op_type == 'b') or (op_type == 's')) : 
            instruction_count = instruction_count + 1

        if (op_type == 'r') :
            rd_bin = rgb.reg_bin(instruction_list[i + 1])
            rs_bin = rgb.reg_bin(instruction_list[i + 2])
            rt_bin = rgb.reg_bin(instruction_list[i + 3])
            instruction_bin = (opcode_bin + rs_bin + rt_bin + rd_bin + '00000' + funct_bin)
            i = i + 4
            file_handle.write(instruction_bin)
            file_handle.write('\n')
        elif (op_type == 's') :
            rd_bin = rgb.reg_bin(instruction_list[i + 1])
            rs_bin = rgb.reg_bin(instruction_list[i + 3])
            rt_bin = rgb.reg_bin(instruction_list[i + 2])
            instruction_bin = (opcode_bin + rs_bin + rt_bin + rd_bin + '00000' + funct_bin)
            i = i + 4
            file_handle.write(instruction_bin)
            file_handle.write('\n')
        elif (op_type == 'i') :
            rt_bin = rgb.reg_bin(instruction_list[i + 1])
            rs_bin = rgb.reg_bin(instruction_list[i + 2])
            immd_bin = imb.immd_bin15(instruction_list[i + 3])
            instruction_bin = (opcode_bin + rs_bin + rt_bin + immd_bin)
            i = i + 4
            file_handle.write(instruction_bin)
            file_handle.write('\n')
        elif (op_type == 'b') :
            rs1_bin = rgb.reg_bin(instruction_list[i + 1])
            rs2_bin = rgb.reg_bin(instruction_list[i + 2])
            line_val = int(instruction_list[i + 3])
            jump_amt = line_val - instruction_count
            immd_bin = imb.immd_bin15_int(jump_amt - 1)
            instruction_bin = (opcode_bin + rs1_bin + rs2_bin + immd_bin)
            print(instruction_bin)
            i = i + 4
            file_handle.write(instruction_bin)
            file_handle.write('\n')
        elif (op_type == 'j') :
            immd_bin = imb.immd_bin26(instruction_list[i + 1])
            instruction_bin = (opcode_bin + immd_bin)
            i = i + 2
            file_handle.write(instruction_bin)
            file_handle.write('\n')
        else :
            print('check the opcodes')
            print('use add, sub, lw, sw, slt, beq or j')

        verilog_file.write(('            %d : instruction = ' %(instruction_count - 1)) + '32\'b' + instruction_bin + ';\n')
    
    
    verilog_file.write('            default : instruction = 0;\n')
    verilog_file.write('        endcase\n')
    verilog_file.write('    end\n')
    verilog_file.write('    assign mem_end = (address > %d) ? 1\'b1 : 1\'b0;' %(instruction_count - 1))
    verilog_file.write('//-----------------------------------------------------------------------\n')
    verilog_file.write('endmodule\n')
    file_handle.close()
    verilog_file.close()
    
    os.system('move binary_instructions.txt ../common_dump')
    os.system('move instruction_mem_rom.v ../test_benches')
    os.chdir('../')