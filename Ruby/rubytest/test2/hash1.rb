h = {"suzuki" => 87, "itou" => 76, "yamada" => 69}
p h

print("キー：itouを削除します\n")
h.delete("itou")
p h

print("キー：kudouを削除します\n")
h.delete("kudou"){|key|
  print("#{key} は存在しません\n")
}
p h