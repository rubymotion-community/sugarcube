class NSView
  include SugarCube::Frameable
end

class CALayer
  include SugarCube::Frameable
end

class NSScreen
  include SugarCube::Frameable
end

class NSWindow

  def x
    self.frame.origin.x
  end

  def setX(newX)
    new_frame = self.frame
    new_frame.origin.x = newX
    self.setFrame(new_frame, display: false)
  end

  def y
    self.frame.origin.y
  end

  def setY(newY)
    new_frame = self.frame
    new_frame.origin.y = newY
    self.setFrame(new_frame, display: false)
  end

  def height
    self.frame.size.height
  end

  def setHeight(newHeight)
    new_frame = self.frame
    new_frame.size.height = newHeight
    self.setFrame(new_frame, display: false)
  end

  def width
    self.frame.size.width
  end

  def setWidth(newWidth)
    new_frame = self.frame
    new_frame.size.width = newWidth
    self.setFrame(new_frame, display: false)
  end

end
