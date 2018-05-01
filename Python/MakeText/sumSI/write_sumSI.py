f = open('write_sumSI.txt', 'w')

for i in range(13,44):
    f.write('sum(SI5*SI' + str(i) + '),')

f.close()
