class SKNode

  def <<(node)
    addChild(node)
  end

  def run_action(action, &completion)
    runAction(action, completion: completion)
  end

  def [](key)
    self.userData ||= {}
    userData[key.to_s]
  end

  def []=(key, value)
    self.userData ||= {}
    userData[key.to_s] = value
  end

  def each_named(name, &block)
    if block.arity == 1
      using_block = -> (node, stop_ptr) { block.call(node) }
    else
      using_block = block
    end
    enumerateChildNodesWithName(name, usingBlock: using_block)
  end

  def to_s
    "#<#{self.class}:0x#{self.object_id.to_s(16)} position=#{position.inspect} name=#{name.inspect}>"
  end

end
