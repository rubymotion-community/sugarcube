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
    
    
    # replace enumerable methods
    #
    # In AnonymousArray:
    # It was not satisfied with the :each method only.
    
    [:each, :map, :collect].each do |method|
      base_method = "anonymousarray_#{method.to_s}".to_sym
      alias_method base_method, method
      define_method method do
        send(base_method) {|o| yield o.to_object}
      end
    end

  end

end

class NSArray

  def to_object
    SugarCube::AnonymousArray.new(self)
  end

end
