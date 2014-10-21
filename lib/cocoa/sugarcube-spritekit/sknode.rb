class SKNode

  def <<(node)
    addChild(node)
  end

  def run_action(action, &completion)
    runAction(action, completion: completion)
  end

  def [](key)
    userData[key]
  end

  def []=(key, value)
    userData[key] = value
  end

  def to_s
    "#<#{self.class}:0x#{self.object_id.to_s(16)} position=#{position.inspect} name=#{name.inspect}>"
  end

end
