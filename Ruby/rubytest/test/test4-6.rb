count = 1

print("[start]\n")

("aa".."az").each{|str|
  print(str + "\n");

  count += 1
  if count > 10 then
    break
  end
}

print("[end]\n")