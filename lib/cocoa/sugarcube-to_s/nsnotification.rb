class NSNotification

  def to_s
    name
  end

  def inspect
    "#<#{self.class.to_s}:0x#{self.object_id.to_s(16)}, "+
      "name=#{self.name.inspect}, object=#{object.inspect}, "+
      "userInfo=#{userInfo.inspect}"+
     ">"
  end

end
