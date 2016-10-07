module SugarCube
  class << Repl

    def window(index=nil)
      if index
        NSApplication.sharedApplication.windows[index]
      elsif NSApplication.sharedApplication.keyWindow
        NSApplication.sharedApplication.keyWindow
      elsif NSApplication.sharedApplication.mainWindow
        NSApplication.sharedApplication.mainWindow
      else
        NSApplication.sharedApplication.windows.select { |window|
          window.contentView != nil && window.contentView.subviews.count > 0
        }.first
      end
    end

    def root
      window.windowController
    end

    def adjust_init(view)
      if view.is_a?(NSView)
        @restore = {
          frame: SugarCube::Repl.frame,
        }
      end
    end

    def blink(color=nil)
      return unless check_sugarcube_view

      blinking_view = NSView.alloc.initWithFrame([[0,0], @adjust_item.frame.size])
      color = color.nscolor if color.respond_to?(:nscolor)
      blinking_view.backgroundColor = color
      blinking_view.alpha = 0
      if @adjust_item.window
        blinking_view.frame = @adjust_item.convertRect([[0, 0], @adjust_item.frame.size], toView: @adjust_item.window)
        @adjust_item.window.addSubview(blinking_view)
      else
        @adjust_item.addSubview(blinking_view)
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

    def register_platform_tree_selectors
      register_tree_selector(NSView, :subviews)
      register_tree_selector(NSWindow) { |window| window.contentView.subviews }
      register_tree_selector(NSWindowController) { |ctlr| [ctlr.window] }
      register_tree_selector(NSViewController) { |ctlr| [ctlr.view] }
      register_tree_selector(NSMenu, :itemArray)
      register_tree_selector(NSMenuItem) { |menu_item| [menu_item.menu] }
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
