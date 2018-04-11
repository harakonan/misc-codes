print("18..20 is \n")
(18..20).each{|num|
  print("num = ", num, "\n")
}

print("\n")

print("\"Ax\"..\"Bc\" is \n")
("Ax".."Bc").each do |str|
  print("str = " + str + "\n")
end