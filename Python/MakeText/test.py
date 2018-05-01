from csv import reader

g = open('amlodipineRegion.csv', 'r')

out = reader(g)
data = [line for line in out]
print(len(data))
print(data[1:len(data)][0])
