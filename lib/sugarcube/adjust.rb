module SugarCube
  module Adjust
    module_function

    def repl_format(format=nil)
      if format
        @@repl_format = format
      else
        # if adjust has not been called, the instance variable has not yet been set
        @@repl_format ||= :ruby
      end
      @@repl_format
    end

    def adjust(view=nil, format=nil)
      SugarCube::Adjust::repl_format(format.to_sym) if format
      @@sugarcube_view ||= nil  #  this looks like a NOOP, but ||= also checks whether the variable exists.  aka: errors happen if we don't do this.
      return @@sugarcube_view if not view

      if view.is_a? Fixnum
        @@sugarcube_items ||= nil
        raise "no views have been assigned to SugarCube::Adjust::tree" unless @@sugarcube_items

        view = @@sugarcube_items[view]
      end

      if view.is_a?(UIView)
        @@sugarcube_view = view
        @@sugarcube_restore = {
          frame: SugarCube::Adjust.frame,
          shadow: SugarCube::Adjust.shadow,
        }

        if format
          puts format_frame view.frame
        end
      end

      view
    end
    alias a adjust

    ##|  FRAME
    def frame f=nil
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      return SugarCube::CoreGraphics::Rect(@@sugarcube_view.frame) if not f

      @@sugarcube_view.frame = f
      puts format_frame(f)

      @@sugarcube_view
    end
    alias f frame

    ##|  ORIGIN
    def left val=1
      SugarCube::Adjust::right -val
    end
    alias l left

    def right val=1
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      f = @@sugarcube_view.frame
      f.origin.x += val
      @@sugarcube_view.frame = f
      puts format_frame(f)

      @@sugarcube_view
    end
    alias r right

    def up val=1
      SugarCube::Adjust::down -val
    end
    alias u up

    def down val=1
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      f = @@sugarcube_view.frame
      f.origin.y += val
      @@sugarcube_view.frame = f
      puts format_frame(f)

      @@sugarcube_view
    end
    alias d down

    def origin x=nil, y=nil
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      f = @@sugarcube_view.frame
      return SugarCube::CoreGraphics::Point(f.origin) if not x

      if y
        f.origin.x = x
        f.origin.y = y
      else
        f.origin = x
      end
      @@sugarcube_view.frame = f
      puts format_frame(f)

      @@sugarcube_view
    end
    alias o origin

    ##|  SIZE
    def thinner val=1
      SugarCube::Adjust::wider -val
    end
    alias n thinner

    def wider val=1
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      f = @@sugarcube_view.frame
      f.size.width += val
      @@sugarcube_view.frame = f
      puts format_frame(f)

      @@sugarcube_view
    end
    alias w wider

    def shorter val=1
      SugarCube::Adjust::taller -val
    end
    alias s shorter

    def taller val=1
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      f = @@sugarcube_view.frame
      f.size.height += val
      @@sugarcube_view.frame = f
      puts format_frame(f)

      @@sugarcube_view
    end
    alias t taller

    def size w=nil, h=nil
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      f = @@sugarcube_view.frame
      return SugarCube::CoreGraphics::Size(f.size) if not w

      if h
        f.size.width = w
        f.size.height = h
      else
        f.size = w
      end
      @@sugarcube_view.frame = f
      puts format_frame(f)

      @@sugarcube_view
    end
    alias z size

    def center(*args)
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      element = nil
      total = nil
      direction = 'h'
      args.each do |option|
        case option
        when String, Symbol  # accept string or symbol
          direction = option.to_s
        when Numeric
          if not total
            total = option
          elsif not element
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

      view = @@sugarcube_view

      left = view.origin.x
      top = view.origin.y

      if /h|x/.match(direction.downcase)
        swidth = view.frame.width
        pwidth = view.superview.frame.width / total
        left = (pwidth - swidth) / 2 + pwidth * (element - 1)
      end
      if /v|y/.match(direction.downcase)
        sheight = view.frame.height
        pheight = view.superview.frame.height / total
        top = (pheight - sheight) / 2 + pheight * (element - 1)
      end

      self.origin left, top
    end
    alias c center

    ##|  SHADOW
    def shadow shadow=nil
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      if shadow
        {
          opacity: :'shadowOpacity=',
          radius: :'shadowRadius=',
          offset: :'shadowOffset=',
          color: :'shadowColor=',
          path: :'shadowPath=',
        }.each { |key, msg|
          if value = shadow[key]
            if key == :color and [Symbol, Fixnum, NSString, UIImage, UIColor].any?{|klass| value.is_a? klass}
              value = value.uicolor.CGColor
            end
            @@sugarcube_view.layer.send(msg, value)
            @@sugarcube_view.layer.masksToBounds = false
            @@sugarcube_view.layer.shouldRasterize = true
          end
        }
        @@sugarcube_view
      else
        {
          opacity: @@sugarcube_view.layer.shadowOpacity,
          radius: @@sugarcube_view.layer.shadowRadius,
          offset: @@sugarcube_view.layer.shadowOffset,
          color: @@sugarcube_view.layer.shadowColor,
          path: @@sugarcube_view.layer.shadowPath,
        }
      end
    end
    alias h shadow

    ##|  TREE
    def tree(item=nil, selector=nil)
      unless item
        item = UIApplication.sharedApplication.keyWindow
      end
      if not item
        puts 'View is nil (no window, view, or controller to display)'
        return
      end

      unless selector
        if item.is_a? UIView
          selector = :subviews
        elsif item.is_a? UIViewController
          selector = :childViewControllers
        else
          raise "Unable to determine a SugarCube::Adjust::tree selector for #{item.class.name}"
        end
      end

      @@sugarcube_items = []
      total = SugarCube::Adjust::draw_tree(item, selector)
      puts ''

      return item
    end

    def draw_tree(item, selector, tab=nil, is_last=true, items_index=0)
      @@sugarcube_items << item

      space = ' '
      if items_index < 10
        print '  '
      elsif items_index < 100
        print ' '
      elsif items_index > 999  # good god, man!
        space = ''
      end
      print items_index.to_s + ":" + space

      if tab
        print tab
        if is_last
          print '`-- '
          tab += '    '
        else
          print '+-- '
          tab += '|   '
        end
      else
        print '. '
        tab = ''
      end

      if self == item
        print "\033[1m"
      end
      if item.is_a? UIView
        puts item.to_s superview: false
      else
        puts item.to_s
      end
      if self == item
        print "\033[0m"
      end

      items = item.send(selector)
      items.each_with_index { |subview, index|
        items_index += 1
        items_index = SugarCube::Adjust::draw_tree(subview, selector, tab, index == items.length - 1, items_index)
      }

      return items_index
    end

    def root
      (UIApplication.sharedApplication.keyWindow || UIApplication.sharedApplication.windows[0]).rootViewController
    end

    ##|  RESTORE
    def restore
      @@sugarcube_view ||= nil
      raise 'no view has been assigned to SugarCube::Adjust::adjust' unless @@sugarcube_view

      @@sugarcube_restore.each do |msg, value|
        SugarCube::Adjust.send(msg, value)
      end
    end

    def format_frame(frame)
      case SugarCube::Adjust::repl_format
        when :json then "{x: #{frame.origin.x}, y: #{frame.origin.y}, width: #{frame.size.width}, height: #{frame.size.height}}"
        when :ruby then "[[#{frame.origin.x}, #{frame.origin.y}], [#{frame.size.width}, #{frame.size.height}]]"
        when nil, :objc
          frame.to_s
        else
          raise "Unknown repl_format #{SugarCube::Adjust::repl_format.inspect}"
      end
    end

  end
end
