f = open('write_CZ.txt', 'w')

for i in range(0, 10):
    f.write('V' + str(17+i*3) + '+')

f.close()
