str = "Tokyo,Osaka,Nagoya,,"

print("対象の文字列:", str, "\n")
print("カンマで分割します\n")

strAry = str.split(",")
p strAry

print("カンマで分割します\n")

strAry = str.split(",", -1)
p strAry

print("カンマで分割します。最大分割数は2です\n")

strAry = str.split(",", 2)
p strAry