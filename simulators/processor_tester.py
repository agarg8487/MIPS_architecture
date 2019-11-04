#Developer : Aditya Terkar, 16EC01003, IIT Bhubaneswar
#Aim : python code for simulating the processor

#--------------------------------standard library imports------------------------------
import os
import subprocess
#--------------------------------------------------------------------------------------
#-------------------------------project imports----------------------------------------
import code_to_bin as ctb
#--------------------------------------------------------------------------------------

#----------------check file existence, convert to binary--------------------------------
os.chdir('../assembly_codes')
#print('printing all the files in the assembly_codes directory')
#print(os.path.exists('trial.vsat'))
file_list = os.listdir()
for file_name in file_list :
    print(file_name)

file_req = input('enter your file name : ')
while (not(os.path.exists(file_req))) :
    print('non existing file name, try again or type exit')
    file_req = input('\nenter your file name : ')
    if(file_req == 'exit') : exit()

instruction_list = list()
with open(file_req,'r') as ins_file :
    for line in ins_file :
        for word in line.split() :
            instruction_list.append(word)
#            print(word) # testing the code

instruction_count = ctb.code_to_bin(instruction_list)
os.system('move binary_instructions.txt ../common_dump')
os.system('move instruction_mem_rom.v ../test_benches')
#-------------------------------------------------------------------------------------

#-----------------------------compile and run the test bench--------------------------
os.chdir('../test_benches')
file_handle = open('ins_mem_size.v', 'w+')
file_handle.write('`define ins_mem_size %d' %(instruction_count) )
file_handle.close()
if (os.path.exists('tb_microprocessor.v') == False) :
    print('could not find tb_microprocesor.v to run the test bench')
    exit()
else :
    subprocess.call('iverilog -o test.vvp tb_microprocessor.v', shell = True)
    subprocess.call('vvp test.vvp')
#------------------------------------------------------------------------------------