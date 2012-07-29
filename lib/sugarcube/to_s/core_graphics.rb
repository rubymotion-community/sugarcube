class CGPoint
  def to_s
    "#{self.class.name}(#{self.x}, #{self.y})"
  end

  def inspect ; to_s ; end
end

class CGSize
  def to_s
    "#{self.class.name}(#{self.width} × #{self.height})"
  end

  def inspect ; to_s ; end
end

class CGRect
  def to_s
    "#{self.class.name}([#{self.origin.x}, #{self.origin.y}],{#{self.size.width} × #{self.size.height}})"
  end

  def inspect ; to_s ; end
end
