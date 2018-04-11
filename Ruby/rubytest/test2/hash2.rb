h = {"suzuki" => 87, "itou" => 76, "yamada" => 69}
p h

print("成績が80よりも小さいキーと値を削除します\n")
h.delete_if {|key, value|
  value < 80
}
p h

print("\n")

h = {"suzuki" => 87, "itou" => 76, "yamada" => 69}
p h

print("成績が80よりも小さいキーと値を削除します\n")
newHash = h.reject {|key, value|
  value < 80
}
p h
p newHash