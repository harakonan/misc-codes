class Car
  def accele(acceletime=1)
    print("アクセルを踏みました\n")
    print("スピードは", calcSpeed(acceletime), "Kmです\n")
  end

  def brake
    print("ブレーキを踏みました\n")
  end

  private

  def calcSpeed(acceletime)
    return acceletime * 10
  end

end

car = Car.new
car.accele(10)
car.calcSpeed(10)