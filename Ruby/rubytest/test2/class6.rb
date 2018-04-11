class Reji
  SHOUHIZEI = 0.08

  def initialize(init=0)
    @sum = init
  end
  
  def kounyuu(kingaku)
    @sum += kingaku
    print("お買い上げ:", kingaku, "\n")
  end
  
  def goukei()
    return @sum * (1 + SHOUHIZEI)
  end
end

reji = Reji.new(0)
reji.kounyuu(100)
reji.kounyuu(80)
print("合計金額:", reji.goukei(), "\n")

print("消費税率:", Reji::SHOUHIZEI)