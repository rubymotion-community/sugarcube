class NSError
  def to_s
    "#<#{self.class.name}:0x#{self.object_id.to_s(16)}, "+
      "URL=#{self.absoluteString.inspect}"+
     ">"
  end
end
