module SugarCube
  module Repl
    module_function

    def window(index=nil)
      if index
        UIApplication.sharedApplication.windows[index]
      else
        UIApplication.sharedApplication.keyWindow
      end
    end

    def root
      window.rootViewController
    end

    def adjust_init(view)
      if view.is_a?(UIView)
        @sugarcube_restore = {
          frame: SugarCube::Repl.frame,
          shadow: SugarCube::Repl.shadow,
        }
      end
    end

    ##|  SHADOW
    def shadow(shadow=nil)
      return unless check_sugarcube_view

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
            @sugarcube_view.layer.send(msg, value)
            @sugarcube_view.layer.masksToBounds = false
            @sugarcube_view.layer.shouldRasterize = true
          end
        }
        @sugarcube_view
      else
        {
          opacity: @sugarcube_view.layer.shadowOpacity,
          radius: @sugarcube_view.layer.shadowRadius,
          offset: @sugarcube_view.layer.shadowOffset,
          color: @sugarcube_view.layer.shadowColor,
          path: @sugarcube_view.layer.shadowPath,
        }
      end
    end
    alias h shadow

    def blink(color=nil)
      return unless check_sugarcube_view

      blinking_view = UIView.alloc.initWithFrame([[0,0], @sugarcube_view.frame.size])
      color = color.uicolor if color.respond_to?(:uicolor)
      blinking_view.backgroundColor = color
      blinking_view.alpha = 0
      if @sugarcube_view.window
        blinking_view.frame = @sugarcube_view.convertRect([[0, 0], @sugarcube_view.frame.size], toView: @sugarcube_view.window)
        @sugarcube_view.window.addSubview(blinking_view)
      else
        @sugarcube_view.addSubview(blinking_view)
      end

      duration = 0.2
      NSView.animateWithDuration(duration * 2, animations: ->{ blinking_view.alpha = 1 }, completion: ->(finished) do
        NSView.animateWithDuration(duration, animations: ->{ blinking_view.alpha = 0 }, completion: ->(finished) do
          NSView.animateWithDuration(duration, animations: ->{ blinking_view.alpha = 1 }, completion: ->(finished) do
            NSView.animateWithDuration(duration, animations: ->{ blinking_view.alpha = 0 }, completion: ->(finished) do
              blinking_view.removeFromSuperview
            end)
          end)
        end)
      end)
    end

    def get_tree_selector(item)
      if item.is_a? UIView
        return :subviews
      elsif item.is_a? UIViewController
        return -> (ctlr) do
          ret = Array.new ctlr.childViewControllers
          if ctlr.presentedViewController && ctlr.presentedViewController.presentingViewController == ctlr
            ret << ctlr.presentedViewController
          end
          ret
        end
      else
        nil
      end
    end

    def draw_tree_item(item)
      if item.is_a?(UIView)
        item.sugarcube_to_s superview: false
      else
        item.to_s
      end
    end

  end
end
