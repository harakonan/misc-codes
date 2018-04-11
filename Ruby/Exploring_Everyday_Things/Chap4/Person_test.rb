Dir.chdir("./Exploring_Everyday_Things/Chap4")

require './Person'

DURATION = 60*9
frequency = 3
use_duration = 1
population_size = 10

person = Person.new(frequency, use_duration)
p person.need_to_go?()

population_size.times {Person.population << Person.new(frequency, use_duration)}

p Person.population()

Person.population.each do |person|
	print(person, " f=", person.frequency, " d=", person.use_duration, " n=",person.need_to_go?, "\n")
end