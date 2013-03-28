class NSSet

  def to_s
    "NSSet(#{self.count}){#{self.allObjects.map{|o| o.inspect}.join(', ')}}"
  end
  
  alias :to_a :allObjects

end
