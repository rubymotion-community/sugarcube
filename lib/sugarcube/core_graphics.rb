
class CGRectArray < Array

  def origin
    return CGPointArray.new(self[0])
  end

  def size
    return CGSizeArray.new(self[1])
  end

end


class CGPointArray < Array

  def x
    return self[0]
  end

  def y
    return self[1]
  end

end

class CGSizeArray < Array

  def width
    return self[0]
  end

  def height
    return self[1]
  end

end


class Kernel

  def Size(w, h)
    retun CGSizeArray.new([w, h])
  end

  def Point(x, y)
    retun CGPointArray.new([x, y])
  end

  # Accepts 2 or 4 arguments.  2 arguments should be a point and a size,
  # 4 should be x, y, w, h
  def Rect(x_or_origin, y_or_size=nil, w=nil, h=nil)
    if not y_or_size
      if CGRect === x_or_origin
        x = x_or_origin.origin.x
        y = x_or_origin.origin.y
        w = x_or_origin.size.width
        h = x_or_origin.size.height
      elsif Array === x_or_origin
        x = x_or_origin[0]
        y = x_or_origin[1]
        w = x_or_origin[2]
        h = x_or_origin[3]
      else
        raise RuntimeError.new("Invalid argument sent to Rect(#{x_or_origin.inspect})")
      end
    elsif not w and not h
      x = x_or_origin.x
      y = x_or_origin.y
      w = y_or_size.width
      h = y_or_size.height
    else
      x = x_or_origin
      y = y_or_size
    end
    return CGRectArray.new([[x, y], [w, h]])
  end

end
