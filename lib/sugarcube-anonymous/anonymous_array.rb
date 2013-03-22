module SugarCube
  class AnonymousArray < Array

    def [] index
      o = super.to_object
      self[index] = o
    end

    def first
      self.size == 0 ? nil : self[0]
    end
    
    def last
      c = self.size
      c == 0 ? nil : self[c - 1]
    end
    
    def to_object
      self
    end

  end

end

class NSArray

  def to_object
    SugarCube::AnonymousArray.new(self)
  end

end
