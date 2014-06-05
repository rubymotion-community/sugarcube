class SKNode

  def <<(node)
    addChild(node)
  end

  def to_s
    "#<#{self.class}:0x#{self.object_id.to_s(16)} position=#{position.inspect}>"
  end

end
