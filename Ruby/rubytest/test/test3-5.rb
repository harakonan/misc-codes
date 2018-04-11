sum = 0
product = "Apple"

print(product)
case product
when "Melon","Banana" then
  sum = sum + 500
  print(":500\n")
when "Apple","Lemon","Orange" then
  sum = sum + 150
  print(":150\n")
end

product = "Banana"

print(product)
case product
when "Melon","Banana" then
  sum = sum + 500
  print(":500\n")
when "Apple","Lemon","Orange" then
  sum = sum + 150
  print(":150\n")
end

print("料金は", sum, "円です\n")