module SugarCube
  # A subclass of Hash that allows its keys to be accessed and assigned by
  # method name.  Useful to quickly mock objects.  To that end, a
  # `NoMethodError` is raised anytime the key doesn't exist (getter or setter)
  #
  # You can convert an existing Hash or NSDictionary into a Struct using the
  # constructor `SugarCube::Struct[hash]`, which I recommend you define as a
  # function.
  #
  # @example
  #     # in app_delegate.rb
  #     ::Struct = SugarCube::Struct
  #     def Struct(hash) ; SugarCube.Struct[hash] ; end
  #
  #     obj = Struct({
  #       'first_name': 'Katsuyoshi',  # strings
  #       company: 'Ito Soft Design',  # and symbols are supported
  #     })
  #     obj.first_name
  #     # => 'Katsuyoshi'
  #     obj.company
  #     # => 'Ito Soft Design'
  #     obj.bla  # => raises NoMethodError
  #     obj.bla = 'bla'  # => raises NoMethodError
  class Struct < Hash

    def method_missing(symbol, *args)
      if args.size == 0
        key = symbol
        key = symbol.to_s unless self.include? key
        if self.include?(key)
          return self[key]
        end
      elsif args.size == 1 && /(.*)=$/ =~ symbol.to_s
        key = $1.to_sym
        key = key.to_s unless self.include? key
        if self.include?(key)
          return self[key] = args.first
        end
      end
      return super
    end

    def to_struct
      self
    end

  end

end


class NSDictionary

  def to_struct
    SugarCube::Struct[self]
  end

end
