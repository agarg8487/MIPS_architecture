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
  b=int(word)-1
  if(b>0) :
    x='{:026b}'.format(b)
  elif (b == 0) :
    x='{:026b}'.format(0)
  else :
    x='{:026b}'.format(max_address_26 + b)  
  return x

def immd_bin15_int(word) :
  max_address_16 =65536
  if(word >0) :
    y='{:016b}'.format(word)
  elif (int(word) == 0) :
    y='{:016b}'.format(0)
  else :
    y='{:016b}'.format(max_address_16 + word)
  #print(y)
  return y