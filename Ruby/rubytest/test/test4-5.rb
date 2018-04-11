print("3.times\n")
3.times{|num|
  print("num = ", num, "\n")
}

print("6.upto(8)\n")
6.upto(8){|num|
  print("num = ", num, "\n")
}

print("8.downto(6)\n")
8.downto(6) do |num|
  print("num = ", num, "\n")
end

print("2.4.step(5.3, 0.8)\n")
2.4.step(5.3, 0.8) do |num|
  print("num = ", num, "\n")
end