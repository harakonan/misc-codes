f = open('write_ICD10.txt', 'w')

for i in range(0, 7):
    if i == 0:
        f.write('J' + str(12 + i))
    else:
        f.write(', ' + 'J' + str(12 + i))
    
f.close()
