module SugarCube
  class << Repl

    def build_default_tree
      build_tree(window)
    end

    ##|  FRAME
    def frame(f=nil)
      return unless check_sugarcube_view

      return @adjust_item.frame unless f

      if defined?(SugarCube::CoreGraphics)
        f = SugarCube::CoreGraphics::Rect(f)
      end
      @adjust_item.frame = f
      puts format_frame(f)

      @adjust_item
    end
    alias f frame

    ##|  ORIGIN
    def left(val=1)
      SugarCube::Repl::right -val
    end
    alias l left

    def right(val=1)
      return unless check_sugarcube_view

      f = @adjust_item.frame
      f.origin.x += val
      @adjust_item.frame = f
      puts format_frame(f)

      @adjust_item
    end
    alias r right

    def up(val=1)
      SugarCube::Repl::down -val
    end
    alias u up

    def down(val=1)
      return unless check_sugarcube_view

      f = @adjust_item.frame
      f.origin.y += val
      @adjust_item.frame = f
      puts format_frame(f)

      @adjust_item
    end
    alias d down

    def origin x=nil, y=nil
      return unless check_sugarcube_view

      f = @adjust_item.frame
      return f.origin unless x

      if y
        f.origin.x = x
        f.origin.y = y
      else
        if defined?(SugarCube::CoreGraphics)
          f.origin = SugarCube::CoreGraphics::Point(x)
        else
          f.origin = x
        end
      end
      @adjust_item.frame = f
      puts format_frame(f)

      @adjust_item
    end
    alias o origin

    ##|  SIZE
    def thinner(val=1)
      SugarCube::Repl::wider -val
    end
    alias n thinner

    def wider(val=1)
      return unless check_sugarcube_view

      f = @adjust_item.frame
      f.size.width += val
      @adjust_item.frame = f
      puts format_frame(f)

      @adjust_item
    end
    alias w wider

    def shorter(val=1)
      SugarCube::Repl::taller -val
    end
    alias s shorter

    def taller(val=1)
      return unless check_sugarcube_view

      f = @adjust_item.frame
      f.size.height += val
      @adjust_item.frame = f
      puts format_frame(f)

      @adjust_item
    end
    alias t taller

    def size(w=nil, h=nil)
      return unless check_sugarcube_view

      f = @adjust_item.frame
      return f.size unless w

      if h
        f.size.width = w
        f.size.height = h
      else
        if defined?(SugarCube::CoreGraphics)
          f.size = SugarCube::CoreGraphics::Size(w)
        else
          f.size = w
        end
      end
      @adjust_item.frame = f
      puts format_frame(f)

      @adjust_item
    end
    alias z size

    ##|  RESTORE
    def restore
      return unless check_sugarcube_view

      @restore.each do |msg, value|
        SugarCube::Repl.send(msg, value)
      end
    end

    def center(*args)
      return unless check_sugarcube_view

      element = nil
      total = nil
      direction = 'h'
      args.each do |option|
        case option
        when String, Symbol  # accept string or symbol
          direction = option.to_s
        when Numeric
          unless total
            total = option
          elsunless element
            element = option
          else
            raise "I don't know what to do with #{option.inspect}"
          end
        else
          raise "I don't know what to do with #{option.inspect}"
        end
      end
      element = 1 unless element
      total = 1 unless total

      view = @adjust_item

      left = view.origin.x
      top = view.origin.y

      if /h|x/.match(direction.downcase)
        swidth = view.frame.size.width
        pwidth = view.superview.frame.size.width / total
        left = (pwidth - swidth) / 2 + pwidth * (element - 1)
      end
      if /v|y/.match(direction.downcase)
        sheight = view.frame.size.height
        pheight = view.superview.frame.size.height / total
        top = (pheight - sheight) / 2 + pheight * (element - 1)
      end

      self.origin left, top
    end
    alias c center

    def register_default_tree_selectors
      register_tree_selector(CALayer, :sublayers)
      if defined?(SKNode)
        register_tree_selector(SKNode, :children)
      end
      register_platform_tree_selectors
    end

    def get_tree_item(item)
      if item.nil? && @default
        @default
      elsif item.nil? || item.is_a?(Fixnum)
        window(item)
      else
        item
      end
    end

    def check_sugarcube_view
      raise 'no view has been assigned to SugarCube::Repl::adjust' unless @adjust_item

      true
    end

    def format_frame(frame)
      "[[#{frame.origin.x}, #{frame.origin.y}], [#{frame.size.width}, #{frame.size.height}]]"
    end

  end
end
