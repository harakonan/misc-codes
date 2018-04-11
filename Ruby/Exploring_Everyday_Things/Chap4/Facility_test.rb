Dir.chdir("./Exploring_Everyday_Things/Chap4")

require './Facility'

DURATION = 60*9
frequency = 3
use_duration = 1
population_size = 10
facilities_per_restroom = 3

facility = Facility.new()
p facility

facilities = []
facilities_per_restroom.times {facilities << Facility.new()}

p facilities

facilities.each do |facility|
	print(facility, " o=", facility.occupier, " d=", facility.duration, "\n")
end

p facilities[1]
p facilities[1].occupier
p facilities[1].occupied?

facilities[0].occupier = Person.new(frequency,use_duration)
p facilities[0].occupier

population_size.times {Person.population << Person.new(frequency, use_duration)}
p Person.population[0..2]
p Person.population.size

p facilities[1].occupy(Person.population[1])
p facilities[1].occupied?
p facilities[0].occupy(Person.population[0])
p Person.population.size

facilities[1].vacate
facilities[0].vacate
p Person.population.size
p Person.population

facilities[0].occupy(Person.population[0])
facilities[1].occupy(Person.population[1])
p Person.population.size
facilities[0].tick
facilities.each do |facility|
	print(facility, " o=", facility.occupier, " d=", facility.duration, "\n")
end
facilities.each do |facility|
	facility.tick
end
print("\n")
facilities.each do |facility|
	print(facility, " o=", facility.occupier, " d=", facility.duration, "\n")
end
p Person.population.size