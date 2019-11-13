#Developer : Aditya Terkar, 16EC01003, IIT Bhubaneswar
#Aim : python code for simulating the processor

#--------------------------------standard library imports------------------------------
import os
import subprocess
#--------------------------------------------------------------------------------------
#-------------------------------project imports----------------------------------------

#--------------------------------------------------------------------------------------
os.chdir('test_benches')
subprocess.call('iverilog -o test.vvp tb_microprocessor.v', shell = True)
subprocess.call('vvp test.vvp')
os.chdir('../')