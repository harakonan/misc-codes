array = Array["赤", "青", "緑"]
for var in array do
  print("Color = " + var + "\n")
end

array = Array[80, 91, 67]
sum = 0
array.each{|num|
  sum += num
  print("金額:", num, "円\n")
}
print("合計金額は", sum, "円です\n")