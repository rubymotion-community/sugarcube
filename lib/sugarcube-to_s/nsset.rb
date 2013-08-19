class NSSet

  def to_s
    "NSSet(#{self.count}){#{self.allObjects.map{|o| o.inspect}.join(', ')}}"
  end
  
end
