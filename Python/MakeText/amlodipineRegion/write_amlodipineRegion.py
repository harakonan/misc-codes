from csv import reader

f = open('write_amlodipineRegion.txt', 'w')
g = open('amlodipineRegion.csv', 'r')

out = reader(g)
data = [line for line in out]

for i in range(1,len(data)):
    f.write('amlodipine[, Region' + data[i][0] + ' := ifelse(Region == ' + data[i][0] + ',1,0)]\r\n')

f.write('\r\n')

for i in range(1,len(data)):
    f.write('Region' + data[i][0] + ' ')

f.close()
