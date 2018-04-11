class Car
  def accele(acceletime)
    print(acceletime, "秒間アクセルを踏みました\n")
  end
end

class Soarer < Car
  def accele(acceletime)
    super
    print("加速しました")
  end
end

soarer = Soarer.new
soarer.accele(10)