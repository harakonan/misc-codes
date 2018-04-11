class Person
	@@population = []
	attr_accessor :frequency
	attr_reader :use_duration
	
	def initialize(frequency=4, use_duration=1)
		@frequency = frequency
		@use_duration = use_duration
	end

	def self.population
		@@population
	end

	def need_to_go?
		rand(DURATION) + 1 <= @frequency
	end
end





