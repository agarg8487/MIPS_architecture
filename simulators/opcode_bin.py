def opcode_bin(word):
 if(word == 'add'):
     return ['000000','100000','r']
 elif(word == 'sub'):
     return ['000000','100001','r']
 elif(word == 'and'):
     return ['000000','100010','r']
 elif(word == 'or'):
      return ['000000','100101','r']
 elif(word == 'slt'):
      return ['000000','101010','r']
 elif(word == 'lw'):
      return ['000001','000000','i']
 elif(word == 'sw'):
     return ['000011','000000','i']
 elif(word == 'beq'):
     return ['000100','000000','i']
 elif(word == 'j'):
     return ['000010','000000','j']