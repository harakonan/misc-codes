from csv import reader

f = open('write_head_JMDC_HS.txt', 'w')
g = open('head_JMDC_HS.csv', 'r')

out = reader(g)
data = [line for line in out]

for i in range(0,len(data)):
	if i == 0:
	    f.write('"' + data[i][0] + '"')
	else:
	    f.write(',"' + data[i][0] + '"')
    
f.close()