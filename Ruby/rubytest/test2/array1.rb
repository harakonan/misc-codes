ary = [3, 4, 2, 5, 1]
p ary

newary = ary.sort
p newary

ary = %w[Kudou Yamada Andou Yoshida]
p ary

newary = ary.sort{|a,b| (-1)*(a <=> b)}
p newary