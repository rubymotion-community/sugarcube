module SugarCube
  module CoreGraphics
    module_function

    # Accepts 1 or 2 arguments
    # 1 argument should be a CGPoint, CGSize, Array[Numeric, Numeric] or UIOffset
    # 2 arguments should be Numeric, Numeric
    def Point(x_or_origin, y=nil)
      unless y
        case x_or_origin
        when CGPoint
          x = x_or_origin.x
          y = x_or_origin.y
        when CGSize
          x = x_or_origin.width
          y = x_or_origin.height
        when UIOffset
          x = x_or_origin.horizontal
          y = x_or_origin.vertical
        when Array
          x = x_or_origin[0]
          y = x_or_origin[1]
        else
          raise RuntimeError.new("Invalid argument sent to Point(#{x_or_origin.inspect})")
        end
      else
        x = x_or_origin
      end
      return CGPoint.new(x, y)
    end

    # Accepts 1 or 2 arguments
    # 1 argument should be a CGPoint, CGSize, Array[Numeric, Numeric] or UIOffset
    # 2 arguments should be Numeric, Numeric
    def Size(w_or_size, h=nil)
      unless h
        case w_or_size
        when CGSize
          w = w_or_size.width
          h = w_or_size.height
        when CGPoint
          w = w_or_size.x
          h = w_or_size.y
        when UIOffset
          w = w_or_size.horizontal
          h = w_or_size.vertical
        when Array
          w = w_or_size[0]
          h = w_or_size[1]
        else
          raise RuntimeError.new("Invalid argument sent to Size(#{w_or_size.inspect})")
        end
      else
        w = w_or_size
      end
      return CGSize.new(w, h)
    end

    # Accepts 1, 2 or 4 arguments.
    # 1 argument should be an Array[Numeric*4], Array[[Numeric*2],[Numeric*2]], CGRect, UIView or CALayar
    # 2 arguments should be a CGPoint and a CGSize,
    # 3 arguments should be either Numeric, Numeric, Size or Point, Numeric, Numeric
    # 4 should be x, y, w, h
    def Rect(x_or_origin, y_or_size=nil, w=nil, h=nil)
      # one arg
      if y_or_size.nil? and w.nil? and h.nil?
        case x_or_origin
        when CGRect
          x = x_or_origin.origin.x
          y = x_or_origin.origin.y
          w = x_or_origin.size.width
          h = x_or_origin.size.height
        when UIView, CALayer
          x = x_or_origin.frame.origin.x
          y = x_or_origin.frame.origin.y
          w = x_or_origin.frame.size.width
          h = x_or_origin.frame.size.height
        when Array
          if x_or_origin.length == 2
            x = x_or_origin[0][0]
            y = x_or_origin[0][1]
            w = x_or_origin[1][0]
            h = x_or_origin[1][1]
          elsif
            x = x_or_origin[0]
            y = x_or_origin[1]
            w = x_or_origin[2]
            h = x_or_origin[3]
          else
            raise RuntimeError.new("Invalid argument sent to Rect(#{x_or_origin.inspect})")
          end
        else
          raise RuntimeError.new("Invalid argument sent to Rect(#{x_or_origin.inspect})")
        end
      # two args
      elsif w.nil? and h.nil?
        x_or_origin = SugarCube::CoreGraphics::Point(x_or_origin) unless x_or_origin.is_a? CGPoint
        x = x_or_origin.x
        y = x_or_origin.y
        y_or_size = SugarCube::CoreGraphics::Size(y_or_size) unless y_or_size.is_a? CGSize
        w = y_or_size.width
        h = y_or_size.height
      # three args
      elsif h.nil?
        if x_or_origin.is_a? Numeric
          # x_or_origin: x, y_or_size: y, w: size
          point = SugarCube::CoreGraphics::Point(x_or_origin, y_or_size)
          size = w
          return SugarCube::CoreGraphics::Rect(point, size)
        elsif w.is_a? Numeric
          # x_or_origin: point, y_or_size: w, w: h
          point = x_or_origin
          size = SugarCube::CoreGraphics::Size(y_or_size, w)
          return SugarCube::CoreGraphics::Rect(point, size)
        else
          raise RuntimeError.new("Invalid arguments sent to Rect(#{x_or_origin.inspect}, #{y_or_size.inspect}, #{w.inspect})")
        end
      else
        x = x_or_origin
        y = y_or_size
      end
      return CGRect.new([x, y], [w, h])
    end

    # Accepts 1..4 arguments.
    # 1 argument should be an Array[Numeric * 1..4], UIEdgeInset, or Numeric
    # 2 arguments should be top/bottom, left/right
    # 3 arguments should be top, left/right, bottom
    # 4 should be top, left, bottom, right
    def EdgeInsets(top_or_inset, left=nil, bottom=nil, right=nil)
      if left.nil? and bottom.nil? and right.nil?
        case top_or_inset
        when UIEdgeInsets
          top = top_or_inset.top
          left = top_or_inset.left
          bottom = top_or_inset.bottom
          right = top_or_inset.right
        when CGRect
          # converting a rect to insets is hard to visualize,
          # but it goes something like this:
          # +-----------.....----------+
          # | origin |y   | top inset  |
          # |--------+    V            |
          # |    x    ..........       |
          # .         .        .       .
          # .-------->.        . right .
          # . left    .        . inset .
          # . inset   .        .<------.
          # .         .        .       .
          # |         ..........   w   |
          # |             ^     +------|
          # | bottom inset|    h| size |
          # +-----------.....----------+
          left = top_or_inset.origin.x
          top = top_or_inset.origin.y
          right = top_or_inset.size.width
          bottom = top_or_inset.size.height
        when Array
          # okay, in this ONE case, I use the splat operator.
          return SugarCube::CoreGraphics::EdgeInsets(*top_or_inset)
        when Numeric
          top = left = bottom = right = top_or_inset
        else
          raise RuntimeError.new("Invalid argument sent to EdgeInsets(#{top_or_inset.inspect})")
        end
      elsif bottom.nil? and right.nil?
        return SugarCube::CoreGraphics::EdgeInsets(top_or_inset, left, top_or_inset, left)
      elsif right.nil?
        return SugarCube::CoreGraphics::EdgeInsets(top_or_inset, left, bottom, left)
      else
        top = top_or_inset
      end
      return UIEdgeInsets.new(top, left, bottom, right)
    end

    # Accepts 1 or 2 arguments.
    # 1 argument should be an Array[2], UIOffset, CGPoint, CGSize, or Numeric
    # 2 should be horizontal, vertical
    def Offset(horizontal_or_offset, vertical=nil)
      unless vertical
        case horizontal_or_offset
        when UIOffset
          horizontal = horizontal_or_offset.horizontal
          vertical = horizontal_or_offset.vertical
        when CGPoint
          horizontal = horizontal_or_offset.x
          vertical = horizontal_or_offset.y
        when CGSize
          horizontal = horizontal_or_offset.width
          vertical = horizontal_or_offset.height
        when Array
          horizontal = horizontal_or_offset[0]
          vertical = horizontal_or_offset[1]
        when Numeric
          horizontal = horizontal_or_offset
          vertical = horizontal_or_offset
        else
          raise RuntimeError.new("Invalid argument sent to Offset(#{horizontal_or_offset.inspect})")
        end
      else
        horizontal = horizontal_or_offset
      end
      return UIOffset.new(horizontal, vertical)
    end

  end
end
