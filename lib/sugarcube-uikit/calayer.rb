class CALayer

  def << (layer)
    self.addSublayer layer
    return self
  end

  def unshift(layer)
    self.insertSublayer(layer, atIndex:0)
    return self
  end

end
