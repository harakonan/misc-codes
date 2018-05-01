from csv import reader

f = open('write_testSY.sql', 'w')
g = open('testSYuni.csv', 'r')

out = reader(g)
data = [line for line in out]

for i in range(1,len(data)):
    f.write('INSERT INTO DISEASE_TABLE VALUES (' + data[i][0] + ',1,0,0,0);\r\n')

f.close()