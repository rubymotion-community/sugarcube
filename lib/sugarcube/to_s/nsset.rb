class NSSet

  def to_s
    "#{self.class.name}(#{self.allObjects.map{|o| o.inspect}.join(', ')})"
  end

end
