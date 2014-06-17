class NSURL

  def to_s
    self.absoluteString
  end

  def inspect
    "#<#{self.class.to_s}:0x#{self.object_id.to_s(16)}, "+
      "URL=#{self.absoluteString.inspect}"+
     ">"
  end

end
