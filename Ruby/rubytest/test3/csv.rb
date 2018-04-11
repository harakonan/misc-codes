Dir.chdir("./rubytest/test3")

require 'csv'

population_range = 10..100

data = {}
population_range.step(10) do |population_size|
	data[population_size] = []
	11.times do |t|
		data[population_size] << population_size*t
	end
end
p data

CSV.open('testcsv.csv', 'w') do |csv|
	lbl = []
	population_range.step(10) {|population_size| lbl << population_size  }
	csv << lbl
	11.times do |t|
		row = []
		population_range.step(10) do |population_size|
			row << data[population_size][t]
		end
		p row
		csv << row
	end
	row = []
	10.times {|t| row << t}
	csv << row
end
