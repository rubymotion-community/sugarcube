module SugarCube
  # A subclass of Hash that allows its keys to be accessed and assigned by
  # method name.  Useful to quickly mock objects.  To that end, a
  # `NoMethodError` is raised anytime the key doesn't exist (getter or setter)
  #
  # You can convert an existing Hash or NSDictionary into a Anonymous using the
  # constructor `SugarCube::Anonymous[hash]`, or you can call `to_object` on a
  # dictionary or hash.
  #
  # @example
  #     obj = {
  #       'first_name': 'Katsuyoshi',  # strings
  #       company: 'Ito Soft Design',  # and symbols are supported
  #     }.to_object
  #
  #     obj.first_name
  #     # => 'Katsuyoshi'
  #     obj.company
  #     # => 'Ito Soft Design'
  #     obj.bla  # => raises NoMethodError
  #     obj.bla = 'bla'  # => raises NoMethodError
  class Anonymous < Hash

    def method_missing(symbol, *args)
      if args.size == 0
        key = symbol
        key = symbol.to_s unless self.include? key
        if self.include?(key)
          self[key] = self[key].to_object
          return self[key]
        end
      elsif args.size == 1 && /(.*)=$/ =~ symbol.to_s
        key = $1.to_sym
        key = key.to_s unless self.include? key
        if self.include?(key)
          return self[key] = args.first.to_object
        end
      end
      return super
    end

    def to_object
      self
    end

  end

end

class NSObject

  def to_object
    self
  end

end

class NSDictionary

  def to_object
    SugarCube::Anonymous[self]
  end

end
