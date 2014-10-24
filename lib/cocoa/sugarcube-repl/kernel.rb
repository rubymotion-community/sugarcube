module Kernel

  def adjust(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.adjust(*args)
    end
  end
  alias a adjust

  def collapse(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.collapse(*args)
    end
  end
  alias coll collapse

  def tree(*args, &sel_blk)
    if self.nil?
      super
    else
      SugarCube::Repl.tree(*args, &sel_blk)
    end
  end

  def root(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.root(*args)
    end
  end

  def frame(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.frame(*args)
    end
  end
  alias f frame

  def left(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.left(*args)
    end
  end
  alias l left

  def right(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.right(*args)
    end
  end
  alias r right

  def up(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.up(*args)
    end
  end
  alias u up

  def down(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.down(*args)
    end
  end
  alias d down

  def origin(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.origin(*args)
    end
  end
  alias o origin

  def thinner(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.thinner(*args)
    end
  end
  alias n thinner

  def wider(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.wider(*args)
    end
  end
  alias w wider

  def shorter(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.shorter(*args)
    end
  end
  alias s shorter

  def taller(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.taller(*args)
    end
  end
  alias t taller

  def size(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.size(*args)
    end
  end
  alias z size

  def center(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.center(*args)
    end
  end
  alias c center

  def shadow(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.shadow(*args)
    end
  end
  alias h shadow

  def restore(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.restore(*args)
    end
  end

  def blink(*args)
    if self.nil?
      super
    else
      SugarCube::Repl.blink(*args)
    end
  end

end
