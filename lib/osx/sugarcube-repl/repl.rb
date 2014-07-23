module SugarCube
  module Repl
    module_function

    def window(index=nil)
      if index
        NSApplication.sharedApplication.windows[index]
      else
        (
          NSApplication.sharedApplication.keyWindow ||
          NSApplication.sharedApplication.mainWindow ||
          NSApplication.sharedApplication.windows[0]
        )
      end
    end

    def root
      window.windowController
    end

    def adjust_init(view)
      if view.is_a?(NSView)
        @sugarcube_restore = {
          frame: SugarCube::Repl.frame,
        }
      end
    end

    def blink(color=nil)
      return unless check_sugarcube_view

      blinking_view = NSView.alloc.initWithFrame([[0,0], @sugarcube_view.frame.size])
      color = color.nscolor if color.respond_to?(:nscolor)
      blinking_view.backgroundColor = color
      blinking_view.alpha = 0
      if @sugarcube_view.window
        blinking_view.frame = @sugarcube_view.convertRect([[0, 0], @sugarcube_view.frame.size], toView: @sugarcube_view.window)
        @sugarcube_view.window.addSubview(blinking_view)
      else
        @sugarcube_view.addSubview(blinking_view)
      end

      duration = 0.2
      NSAnimationContext.runAnimationGroup(-> (context) do
        context.duration = duration * 2
        blinking_view.animator.alpha = 1
      end, completionHandler: -> do
        NSAnimationContext.runAnimationGroup(-> (context) do
          context.duration = duration
          blinking_view.animator.alpha = 0
        end, completionHandler: -> do
          NSAnimationContext.runAnimationGroup(-> (context) do
            context.duration = duration
            blinking_view.animator.alpha = 1
          end, completionHandler: -> do
            NSAnimationContext.runAnimationGroup(-> (context) do
              context.duration = duration
              blinking_view.animator.alpha = 0
            end, completionHandler: -> do
              blinking_view.removeFromSuperview
            end)
          end)
        end)
      end)
    end

    def get_tree_selector(item)
      if item.is_a? NSView
        return :subviews
      elsif item.is_a? NSWindow
        item = item.contentView
        return :subviews
      elsif item.is_a? NSWindowController
        return -> (ctlr) { [ctlr.window] }
      elsif item.is_a? NSViewController
        return -> (ctlr) { [ctlr.view] }
      elsif item.is_a? NSMenu
        return :itemArray
      elsif item.is_a? NSMenuItem
        return -> (menu_item) { [menu_item.menu] }
      else
        nil
      end
    end

    def draw_tree_item(item)
      if item.is_a? NSView
        item.sugarcube_to_s superview: false
      else
        item.to_s
      end
    end

  end
end
