youbi = %w[日 月 火 水 木 金 土]

t = Time.now

print(t.year, "年", t.month, "月", t.day, "日\n")
print(youbi[t.wday], "曜日\n")
print(t.hour, "時", t.min, "分", t.sec, "秒\n")
print("TimeZone:", t.zone, "\n")
print("今年の元旦から数えて", t.yday, "日目\n")

print("\n")

t = Time.local(2015)

print(t.year, "年", t.month, "月", t.day, "日\n")
print(youbi[t.wday], "曜日\n")
print(t.hour, "時", t.min, "分", t.sec, "秒\n")
print("TimeZone:", t.zone, "\n")
print("今年の元旦から数えて", t.yday, "日目\n")