class NSArray

  # @param type [Symbol] type A pointer type from the list at {http://www.rubymotion.com/developer-center/guides/runtime/ RubyMotion Pointers Reference#_pointers}
  # @return [Pointer] A pointer to the array, of the specified type
  def to_pointer(type)
    ret = Pointer.new(type, self.length)
    self.each_index do |i|
      ret[i] = self[i]
    end
    ret
  end

end
