module SugarCube
  module Adjust
    module_function

    def adjust view=nil
      @@sugarcube_view ||= nil
      return @@sugarcube_view if not view

      @@sugarcube_view = view
      @@sugarcube_restore = {
        frame: SugarCube::Adjust.frame,
        shadow: SugarCube::Adjust.shadow,
      }

      view
    end
    alias :a :adjust

    ##|  FRAME
    def frame f=nil
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      return SugarCube::CoreGraphics::Rect(@@sugarcube_view.frame) if not f

      @@sugarcube_view.frame = f
    end
    alias :f :frame

    ##|  ORIGIN
    def left val=1
      SugarCube::right -val
    end
    alias :l :left

    def right val=1
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      f = @@sugarcube_view.frame
      f.origin.x += val
      @@sugarcube_view.frame = f
    end
    alias :r :right

    def up val=1
      SugarCube::down -val
    end
    alias :u :up

    def down val=1
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      f = @@sugarcube_view.frame
      f.origin.y += val
      @@sugarcube_view.frame = f
    end
    alias :d :down

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
    end
    alias :o :origin

    ##|  SIZE
    def thinner val=1
      SugarCube::wider -val
    end
    alias :n :thinner

    def wider val=1
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      f = @@sugarcube_view.frame
      f.size.width += val
      @@sugarcube_view.frame = f
    end
    alias :w :wider

    def shorter val=1
      SugarCube::taller -val
    end
    alias :s :shorter

    def taller val=1
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      f = @@sugarcube_view.frame
      f.size.height += val
      @@sugarcube_view.frame = f
    end
    alias :t :taller

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
    end
    alias :z :size

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
            if key == :color
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
    alias :h :shadow

    ##|  RESTORE
    def restore
      @@sugarcube_view ||= nil
      raise "no view has been assigned to SugarCube::Adjust::adjust" unless @@sugarcube_view

      @@sugarcube_restore.each do |msg, value|
        SugarCube::Adjust.send(msg, value)
      end
    end

  end
end
