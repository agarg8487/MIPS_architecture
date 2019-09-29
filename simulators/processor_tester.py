#Developer : Aditya Terkar, 16EC01003, IIT Bhubaneswar
#Aim : python code for simulating the processor

#--------------------------------standard library imports------------------------------
import os
import subprocess
#--------------------------------------------------------------------------------------
#-------------------------------project imports----------------------------------------
import code_to_bin as ctb
import subprocess
#--------------------------------------------------------------------------------------

#----------------check file existence, convert to binary--------------------------------
os.chdir('../assembly_codes')
print('printing all the files in the assembly_codes directory')
file_list = os.listdir()
for i in range(file_list) :
    print(file_list[i])

file_req = input('enter your file name : ')
while ((os.path.exists((file_req) == False) or (file_req != 'exit')) :
    print('non existing file name, try again or type exit')
    file_req = input('\nenter your file name :')

if(file_req == 'exit') : exit()

instruction_list = open((file_req),'r')
ctb.code_to_bin(instruction_list)
#-------------------------------------------------------------------------------------

#-----------------------------compile and run the test bench--------------------------
os.chdir('../test_benches')
if (os.path.exists('tb_microprocessor.v') == False) :
    print('could not find tb_microprocesor.v to run the test bench')
    exit()
else :
    subprocess.call('iverilog -o test.vvp tb_microprocessor.v', shell = True)
    subprocess.call('vvp test.vvp')
#------------------------------------------------------------------------------------