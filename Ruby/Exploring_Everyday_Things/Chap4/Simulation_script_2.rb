Dir.chdir("./Exploring_Everyday_Things/Chap4")

require 'csv'
require './Restroom_class'

# Simulation script 2

DURATION = 60*9

frequency = 3
facilities_per_restroom_range = 1..30
use_duration = 1
population_size = 1000

data = {}

facilities_per_restroom_range.each do |facilities_per_restroom|
    Person.population.clear
    population_size.times { Person.population << Person.new(frequency, use_duration) }
    data[facilities_per_restroom] = []
    restroom = Restroom.new facilities_per_restroom

    # iterate over a period
    DURATION.times do |t|
        data[facilities_per_restroom] << restroom.queue.size # we want the queue size
        queue = restroom.queue.clone # clone the queue so that we don't mess up the live one
        restroom.queue.clear # clear the queue

        # let everyone from the queue enter the restroom first
        until queue.empty?
            restroom.enter queue.shift # de-queue the first person in line and move him to the restroom
        end

        # for each person in the population check if he needs to go
        Person.population.each do |person|
            if person.need_to_go?
                restroom.enter person
            end
        end
        restroom.tick
    end
end

# write the temp store into CSV
CSV.open('simulation2.csv', 'w') do |csv|
    # setup labels
    lbl = []
    facilities_per_restroom_range.each {|facilities_per_restroom| lbl << facilities_per_restroom  }
    csv << lbl

    # write the data
    DURATION.times do |t|
        row = []
        facilities_per_restroom_range.each do |facilities_per_restroom|
            row << data[facilities_per_restroom][t]
        end
        csv << row
    end
end

p "simulation 2 end"