Dir.chdir("./Exploring_Everyday_Things/Chap4")

require './Restroom_class'

DURATION = 20
frequency = 3
use_duration = 1
population_range = 50..600
facilities_per_restroom = 3

data = {}
population_range.step(50) do |population_size|
	Person.population().clear
	population_size.times {Person.population << Person.new(frequency, use_duration)}
	data[population_size] = []
	restroom = Restroom.new(facilities_per_restroom)

	DURATION.times do |t|
		data[population_size] << restroom.queue.size
		queue = restroom.queue.clear

		until queue.empty?
			restroom.enter queue.shift
		end

		Person.population.each do |person|
			if person.need_to_go?
				restroom.enter person
			end
		end
		restroom.tick
	end
end

data.each do |d|
	p d
end

