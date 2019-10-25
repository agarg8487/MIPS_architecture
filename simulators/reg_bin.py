def reg_bin(word):
 if(word == 'r0'):
  return '00000'
 elif(word == 'r1'):
  return '00001'
 elif(word == 'r2'):
  return '00010'
 elif(word == 'r3'):
  return '00011'
 elif(word == 'r4'):
  return '00100'
 elif(word == 'r5'):
  return '00101'
 elif(word == 'r6'):
  return '00110'
 elif(word == 'r7'):
  return '00111'
 elif(word == 'r8'):
  return '01000'
 elif(word == 'r9'):
  return '01001'
 elif(word == 'r10'):
  return '01010'
 elif(word == 'r11'):
  return '01011'
 elif(word == 'r2'):
  return '01100'
 elif(word == 'r13'):
  return '01101'
 elif(word == 'r14'):
  return '01110'
 elif(word == 'r15'):
  return '01111'
 elif(word == 'r16'):
  return '10000'
 elif(word == 'r17'):
  return '10001'
 elif(word == 'r18'):
  return '10010'
 elif(word == 'r19'):
  return '10011'
 elif(word == 'r20'):
  return '10100'
 elif(word == 'r21'):
  return '10101'
 elif(word == 'r22'):
  return '10110'
 elif(word == 'r23'):
  return '10111'
 elif(word == 'r24'):
  return '11000'
 elif(word == 'r25'):
  return '11001'
 elif(word == 'r26'):
  return '11010'
 elif(word == 'r27'):
  return '11011'
 elif(word == 'r28'):
  return '11100'
 elif(word == 'r29'):
  return '11101'
 elif(word == 'r30'):
  return '11110'
 elif(word == 'r31'):
  return '11111'
else :
    print('invalid register name use r0-r31')
    exit()