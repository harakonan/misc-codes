def printHello
  print("Hello\n")
end

printHello

def printHello(msg="No msg", name="No name")
  print(msg + "," + name + "\n")
end

printHello("こんにちは", "佐藤")
printHello("お元気ですか")
printHello()

def printHello(msg, *names)
  allname = ""
  names.each do |name|
   allname << name << " "
  end
  print(msg + "," + allname + "\n")
end

printHello("Hello")
printHello("Hello", "Yamada")
printHello("Hello", "Yamada", "Endou")
printHello("Hello", "Yamada", "Endou", "Katou", "Takahashi")