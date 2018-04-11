a = 10..600
p a.min

max_rand=5

class Randque
	attr_accessor :queue
	def initialize(max_rand=5)
		@queue = rand(max_rand)
	end
end

restrooms = []

4.times do
	restrooms << Randque.new
end

p restrooms

p restrooms.min {|n,m| n.queue <=> m.queue}

restrooms_queue = []
restrooms.each {|restroom| restrooms_queue << restroom.queue}
p restrooms_queue.min

3.times do |t|
	restrooms.each do |restroom|
		restroom.queue = (t > 1) ? 6 : rand(max_rand)
	end
	p restrooms.min {|n,m| n.queue <=> m.queue}
end