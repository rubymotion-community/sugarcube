
class CGRectArray < Array

  def initialize args
    if args.length == 4
      super [CGPointArray.new([args[0], args[1]]), CGSizeArray.new([args[2], args[3]])]
    else
      unless CGPointArray === args[0]
        args[0] = Point(args[0])
      end
      unless CGSizeArray === args[1]
        args[1] = Size(args[1])
      end
      super [args[0], args[1]]
    end
  end

  def origin
    return self[0]
  end

  def origin= val
    self[0] = Point(val)
  end

  def size
    return self[1]
  end

  def size= val
    self[1] = Size(val)
  end

end


class CGPointArray < Array

  def x
    return self[0]
  end

  def x= val
    self[0] = val
  end

  def y
    return self[1]
  end

  def y= val
    self[1] = val
  end

end

class CGSizeArray < Array

  def width
    return self[0]
  end

  def width= val
    self[0] = val
  end

  def height
    return self[1]
  end

  def height= val
    self[1] = val
  end

end


module SugarCube
  class Kernel

    def Size(w_or_size, h=nil)
      if not h
        if CGSize === w_or_size
          w = w_or_size.width
          h = w_or_size.height
        elsif Array === w_or_size
          w = w_or_size[0]
          h = w_or_size[1]
        else
          raise RuntimeError.new("Invalid argument sent to Size(#{w_or_size.inspect})")
        end
      else
        w = w_or_size
      end
      return CGSizeArray.new([w, h])
    end

    def Point(x_or_origin, y=nil)
      if not y
        if CGPoint === x_or_origin
          x = x_or_origin.x
          y = x_or_origin.y
        elsif Array === x_or_origin
          x = x_or_origin[0]
          y = x_or_origin[1]
        else
          raise RuntimeError.new("Invalid argument sent to Point(#{x_or_origin.inspect})")
        end
      else
        x = x_or_origin
      end
      return CGPointArray.new([x, y])
    end

    # Accepts 2 or 4 arguments.  2 arguments should be a point and a size,
    # 4 should be x, y, w, h
    def Rect(x_or_origin, y_or_size=nil, w=nil, h=nil)
      if not y_or_size
        if CGRectArray === x_or_origin
          x = x_or_origin[0][0]
          y = x_or_origin[0][1]
          w = x_or_origin[1][0]
          h = x_or_origin[1][1]
        elsif CGRect === x_or_origin
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
end
