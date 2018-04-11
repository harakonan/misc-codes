jikokuyouso = %w[秒 分 時 日 月 年 曜日 年内通算日 夏時間 タイムゾーン]

t = Time.now
ary = t.to_a

index = 0

ary.each do |youso|
  print(jikokuyouso[index] , ":", youso, "\n")
  index += 1
end