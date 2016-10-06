module SugarCube
  class << Repl

    def window(index=nil)
      if index
        UIApplication.sharedApplication.windows[index]
      elsif UIApplication.sharedApplication.keyWindow
        UIApplication.sharedApplication.keyWindow
      else
        UIApplication.sharedApplication.windows.select { |window| window.subviews.count > 0 }.first
      end
    end

    def root
      window.rootViewController
    end

    def adjust_init(view)
      if view.is_a?(UIView)
        @restore = {
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
            @adjust_item.layer.send(msg, value)
            @adjust_item.layer.masksToBounds = false
            @adjust_item.layer.shouldRasterize = true
          end
        }
        @adjust_item
      else
        {
          opacity: @adjust_item.layer.shadowOpacity,
          radius: @adjust_item.layer.shadowRadius,
          offset: @adjust_item.layer.shadowOffset,
          color: @adjust_item.layer.shadowColor,
          path: @adjust_item.layer.shadowPath,
        }
      end
    end
    alias h shadow

    def blink(color=nil)
      return unless check_sugarcube_view

      blinking_view = UIView.alloc.initWithFrame([[0,0], @adjust_item.frame.size])
      color = color.uicolor if color.respond_to?(:uicolor)
      blinking_view.backgroundColor = color
      blinking_view.alpha = 0
      if @adjust_item.window
        blinking_view.frame = @adjust_item.convertRect([[0, 0], @adjust_item.frame.size], toView: @adjust_item.window)
        @adjust_item.window.addSubview(blinking_view)
      else
        @adjust_item.addSubview(blinking_view)
      end

      duration = 0.2
      UIView.animateWithDuration(duration * 2, animations: ->{ blinking_view.alpha = 1 }, completion: ->(finished) do
        UIView.animateWithDuration(duration, animations: ->{ blinking_view.alpha = 0 }, completion: ->(finished) do
          UIView.animateWithDuration(duration, animations: ->{ blinking_view.alpha = 1 }, completion: ->(finished) do
            UIView.animateWithDuration(duration, animations: ->{ blinking_view.alpha = 0 }, completion: ->(finished) do
              blinking_view.removeFromSuperview
            end)
          end)
        end)
      end)
    end

    def register_platform_tree_selectors
      register_tree_selector(UIView, :subviews)
      register_tree_selector(UIViewController) do |ctlr|
        ret = Array.new ctlr.childViewControllers
        if ctlr.presentedViewController && ctlr.presentedViewController.presentingViewController == ctlr
          ret << ctlr.presentedViewController
        end
        ret
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
