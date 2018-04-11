def keisan(num1, num2)
  print("num1 = ", num1, "\n")
  print("num2 = ", num2, "\n")
  return num1 + num2, num1 - num2
end

plus, minus = keisan(10, 25)
print("加算の結果:", plus, "\n")
print("減算の結果:", minus, "\n")

print("\n")

array = keisan(1,2)
p array
print(array[0])