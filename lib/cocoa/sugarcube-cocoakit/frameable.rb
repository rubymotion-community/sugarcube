module SugarCube
  # Easily get and set UIView or CALayer frame properties
  #
  # UIView and CALayer both have a 'frame' property that you can edit or access
  # using these methods. Written as a module so we don't have to copy/paste the
  # code into both classes.
  module Frameable

    def x
      self.frame.origin.x
    end

    def setX(newX)
      new_frame = self.frame
      new_frame.origin.x = newX
      self.frame = new_frame
    end

    def y
      self.frame.origin.y
    end

    def setY(newY)
      new_frame = self.frame
      new_frame.origin.y = newY
      self.frame = new_frame
    end

    def height
      self.frame.size.height
    end

    def setHeight(newHeight)
      new_frame = self.frame
      new_frame.size.height = newHeight
      self.frame = new_frame
    end

    def width
      self.frame.size.width
    end

    def setWidth(newWidth)
      new_frame = self.frame
      new_frame.size.width = newWidth
      self.frame = new_frame
    end

  end
end
