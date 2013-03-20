class NSDictionary

  def method_missing(symbol, *args)
    if args.size == 0
      key = symbol
      key = symbol.to_s unless self.include? key
      if self.include? key
        return valueForKey key
      end
    end
    super
  end

end

class NSMutableDictionary

  def method_missing(methId, *args)
    if args.size == 1
      if /(.*)=$/ =~ methId.to_s
        key = $1
        sym = key.to_sym
        key = sym if self.include? sym
        if self.include? key
          self[key] = args.first
          return
        end
      end
    end
    super
  end

end
