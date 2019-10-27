#Authors : Aditya Terkar, 16EC01003, IIT Bhubaneswar
#Aim : making a python file for converting assembly file to binary instructions

#-------------------standard library imports--------------------------------
import os
#---------------------------------------------------------------------------

#----------------standard project imports-----------------------------------
import reg_bin as rgb
import opcode_bin as opb
import immd_bin as imb
#---------------------------------------------------------------------------
def code_to_bin (instruction_list,file_name) :    
    i = 0
    instruction_count = 0;
    file_name = (file_name + '.txt')
    file_handle = open(file_name,'w+')
    while ( i  < len(instruction_list)) :
        opcode = opb.opcode_bin(instruction_list[i])
        opcode_bin = opcode[0]
        funct_bin = opcode[1]
        op_type = opcode[2]
        if (op_type == 'r') :
            rs_bin = rgb.reg_bin(instruction_list[i + 1])
            rt_bin = rgb.reg_bin(instruction_list[i + 2])
            rd_bin = rgb.reg_bin(instruction_list[i + 3])
            instruction_bin = (opcode_bin + rs_bin + rt_bin + rd_bin + '00000' + funct_bin)
            i = i + 4
            file_handle.write(instruction_bin)
            file_handle.write('\n')
        elif (op_type == 'i') :
            rs_bin = rgb.reg_bin(instruction_list[i + 1])
            rt_bin = rgb.reg_bin(instruction_list[i + 2])
            immd_bin = imb.immd_bin15(instruction_list[i + 3])
            instruction_bin = (opcode_bin + rs_bin + rt_bin + immd_bin)
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

    file_handle.close()






