Dir.chdir("./Exploring_Everyday_Things/Chap4")

require './Restroom_class'

DURATION = 60*9
frequency = 3
use_duration = 1
population_size = 10
facilities_per_restroom = 3

restroom = Restroom.new
p restroom
restroom.facilities.each do |facility|
  print(facility, " o=", facility.occupier, " d=", facility.duration, "\n")
end
p restroom.queue

population_size.times {Person.population << Person.new(frequency, use_duration)}
p Person.population
p Person.population.size

(restroom.facilities.size + 1).times do
  restroom.enter(Person.population[0])
  restroom.facilities.each do |facility|
    print(facility, " o=", facility.occupier, " d=", facility.duration, "\n")
  end
  p Person.population
  p Person.population.size
end
p restroom.queue

2.times do 
  restroom.tick
  restroom.facilities.each do |facility|
    print(facility, " o=", facility.occupier, " d=", facility.duration, "\n")
  end
end
p Person.population
p Person.population.size

restroom.enter restroom.queue.shift
restroom.facilities.each do |facility|
  print(facility, " o=", facility.occupier, " d=", facility.duration, "\n")
end
p restroom.queue
p Person.population.size