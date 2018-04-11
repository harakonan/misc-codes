print("[start]\n")

count = 0

("aa".."az").each{|str|
  count += 1
  if count % 3 != 0 then
    next
  end

  print(str + "\n");
}

print("[end]\n")