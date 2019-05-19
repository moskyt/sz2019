class Rational
  def frac
    self - self.floor
  end  
end

class Float
  def frac
    self - self.floor
  end  
end
