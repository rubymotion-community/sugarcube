module Kernel

  def adjust(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.adjust(*args)
    end
  end
  alias a adjust

  def tree(*args, &sel_blk)
    if self.nil?
      super
    else
      SugarCube::Repl.tree(*args, &sel_blk)
    end
  end

end
