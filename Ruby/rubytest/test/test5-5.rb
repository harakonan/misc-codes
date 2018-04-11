addressh1 = Hash.new("none")
addressh1["Itou"] = "Tokyo"

print("住所 : ", addressh1["Itou"], "\n")
print("住所 : ", addressh1["Yamada"], "\n")
p addressh1

print("\n");

addressh2 = Hash.new{|hash, key|
  hash[key] = key
}

print("住所 : ", addressh2["Yamada"], "\n")
print("住所 : ", addressh2["Takahashi"], "\n")
print("要素数 : ",addressh2.length(), "\n")
p addressh2

print("\n");

addressh3 = Hash.new{|hash, key|
  key
}

print("住所 : ", addressh3["Yamada"], "\n")
print("住所 : ", addressh3["Takahashi"], "\n")
print("要素数 : ",addressh3.length(), "\n")
p addressh3

print("\n");

addressh4 = Hash.new("none")

print("住所 : ", addressh4["Itou"], "\n")
print("住所 : ", addressh4.fetch("Yamada", "nothing"), "\n")
print("住所 : ", addressh4.fetch("Endou"){|key|key}, "\n")
p addressh4

print("\n");

addressh5 = Hash.new()
addressh5.default = "none"
print("住所 : ", addressh5["Yamada"], "\n")
p addressh5