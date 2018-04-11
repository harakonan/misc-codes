keyAry = ["suzuki", "itou", "yamada"]
keyValue = [87, 76, 69]
ary = [keyAry,keyValue].transpose
h = Hash[*ary.flatten]

p ary
p ary.flatten
p h