f = open('write_KI.txt', 'w')

for i in range(0,15):
    f.write('V'+ str(9+i*4) + '*V'+ str(10+i*4) + '+')

for i in range(0,4):
    f.write('V'+ str(71+i*4) + '*V'+ str(72+i*4) + '+')

f.close()
