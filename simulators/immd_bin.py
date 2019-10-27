def immd_bin15(word):
  max_address_16 = 65536
  if(int(word)>0) :
    y='{:016b}'.format(int(word))
  elif (int(word) == 0) :
    y='{:016b}'.format(0)
  else :
    y='{:016b}'.format(max_address_16 + int(word))
  #print(y)
  return y

def immd_bin26(word):
  max_address_26 = 67108864
  if(int(word)>0) :
    x='{:026b}'.format(int(word))
  elif (int(word) == 0) :
    x='{:026b}'.format(0)
  else :
    x='{:026b}'.format(max_address_26 + int(word))  
  return x