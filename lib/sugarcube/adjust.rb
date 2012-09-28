module SugarCube
  module Adjust
    module_function

    def adjust(view=nil, format=:default)
      @@repl_format = format.to_sym
      @@sugarcube_view ||= nil
      return @@sugarcube_view if not view

      if view.is_a? Fixnum
        @@sugarcube_views ||= nil
        raise "no views have been assigned to SugarCube::Adjust::tree" unless @@sugarcube_views

        view = @@sugarcube_views[view]
      end

      @@sugarcube_view = view
      @@sugarcube_restore = {
        frame: SugarCube::Adjust.frame,
        shadow: SugarCube::Adjust.shadow,
      }

      interpolated view
    end
    alias a adjust

    ##|  FRAME
    def frame f=nil
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      return SugarCube::CoreGraphics::Rect(@@sugarcube_view.frame) if not f

      @@sugarcube_view.frame = f
      interpolated f
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
      interpolated f
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
      interpolated f
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
      interpolated f
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
      interpolated f
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
      interpolated f
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
      interpolated f
    end
    alias z size

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
    def tree(view=nil, tab=nil, is_last=true, views_index=nil)
      unless view
        view = UIApplication.sharedApplication.keyWindow
      end

      if not views_index
        is_first = true
        @@sugarcube_views = [view]
        views_index = 0
      else
        is_first = false
        @@sugarcube_views << view
      end

      space = ' '
      if views_index < 10
        print "  "
      elsif views_index < 100
        print " "
      elsif views_index > 999  # good god, man!
        space = ''
      end
      print views_index.to_s + ":" + space

      if tab
        print tab
        print is_last ? "`-- " : "+-- "
        tab += is_last ? "    " : "|   "
      else
        print ". "
        tab = ""
      end

      if not view
        puts "View is nil (no window or view to display)"
      else
        if self == view
          print "\033[1m"
        end
        puts interpolated(view)
        if self == view
          print "\033[0m"
        end

        view.subviews.each_index {|index|
          subview = view.subviews[index]
          views_index += 1
          views_index = tree(subview, tab, index == view.subviews.length - 1, views_index)
        }
      end

      return is_first ? view : views_index
    end

    ##|  RESTORE
    def restore
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      @@sugarcube_restore.each do |msg, value|
        SugarCube::Adjust.send(msg, value)
      end
    end

    def interpolated(view=UIApplication.sharedApplication.keyWindow)
      @@repl_format ||= :default  #if adjust has not been called, the instance variable has not yet been set
      frame_params = case @@repl_format
        when :json then "[x: #{view.frame.origin.x}, y: #{view.frame.origin.y}, height: #{view.frame.size.height}, width: #{view.frame.size.width}]"
        when :objc then "[[#{view.frame.origin.x}, #{view.frame.origin.y}], [#{view.frame.size.height}, #{view.frame.size.width}]]"
#        when nil, "default" then view.frame.to_s
        else
          view.frame.to_s
      end
      "#{view.class.name}(##{view.object_id.to_s(16)}: #{frame_params})"
    end

  end
end
