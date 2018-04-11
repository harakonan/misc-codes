count = 0

print("[start]\n")

("aa".."ae").each{|str|
  count += 1

  if count % 3 == 0 then
    redo
  end

  print(count, ":" + str + "\n");
}

print("[end]\n")