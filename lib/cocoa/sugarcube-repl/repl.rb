module Kernel

  def adjust(*args)
    SugarCube::Adjust.adjust(*args)
  end
  alias a adjust

  def tree(*args)
    SugarCube::Adjust.tree(*args)
  end

  def root(*args)
    SugarCube::Adjust.root(*args)
  end

  def frame(*args)
    SugarCube::Adjust.frame(*args)
  end
  alias f frame

  def left(*args)
    SugarCube::Adjust.left(*args)
  end
  alias l left

  def right(*args)
    SugarCube::Adjust.right(*args)
  end
  alias r right

  def up(*args)
    SugarCube::Adjust.up(*args)
  end
  alias u up

  def down(*args)
    SugarCube::Adjust.down(*args)
  end
  alias d down

  def origin(*args)
    SugarCube::Adjust.origin(*args)
  end
  alias o origin

  def thinner(*args)
    SugarCube::Adjust.thinner(*args)
  end
  alias n thinner

  def wider(*args)
    SugarCube::Adjust.wider(*args)
  end
  alias w wider

  def shorter(*args)
    SugarCube::Adjust.shorter(*args)
  end
  alias s shorter

  def taller(*args)
    SugarCube::Adjust.taller(*args)
  end
  alias t taller

  def size(*args)
    SugarCube::Adjust.size(*args)
  end
  alias z size

  def center(*args)
    SugarCube::Adjust.center(*args)
  end
  alias c center

  def shadow(*args)
    SugarCube::Adjust.shadow(*args)
  end
  alias h shadow

  def restore(*args)
    SugarCube::Adjust.restore(*args)
  end

  def blink(*args)
    SugarCube::Adjust.blink(*args)
  end

end
