module SugarCube
  module Repl
    module_function

    @sugarcube_view = nil
    @sugarcube_items = nil
    @sugarcube_collapsed_items = nil
    @sugarcube_restore = nil

    def adjust(view=nil)
      return @sugarcube_view unless view

      if view.is_a? Fixnum
        @sugarcube_items ||= SugarCube::Repl::build_tree(window, :subviews)
        view = @sugarcube_items[view]
      end

      # a/adjust will return this object
      @sugarcube_view = view

      adjust_init(view)

      view
    end
    alias a adjust

    def collapse(view)
      if view.is_a? Fixnum
        @sugarcube_items ||= SugarCube::Repl::build_tree(window, :subviews)
        view = @sugarcube_items[view]
      end

      @sugarcube_collapsed_items ||= []
      if @sugarcube_collapsed_items.include?(view)
        @sugarcube_collapsed_items.delete(view)
      else
        @sugarcube_collapsed_items << view
      end

      retval = tree

      if @sugarcube_collapsed_items
        @sugarcube_collapsed_items.keep_if { |v| @sugarcube_items.include? v }
      end

      retval
    end
    alias coll collapse

    ##|  FRAME
    def frame(f=nil)
      return unless check_sugarcube_view

      return @sugarcube_view.frame unless f

      f = SugarCube::CoreGraphics::Rect(f)
      @sugarcube_view.frame = f
      puts format_frame(f)

      @sugarcube_view
    end
    alias f frame

    ##|  ORIGIN
    def left(val=1)
      SugarCube::Repl::right -val
    end
    alias l left

    def right(val=1)
      return unless check_sugarcube_view

      f = @sugarcube_view.frame
      f.origin.x += val
      @sugarcube_view.frame = f
      puts format_frame(f)

      @sugarcube_view
    end
    alias r right

    def up(val=1)
      SugarCube::Repl::down -val
    end
    alias u up

    def down(val=1)
      return unless check_sugarcube_view

      f = @sugarcube_view.frame
      f.origin.y += val
      @sugarcube_view.frame = f
      puts format_frame(f)

      @sugarcube_view
    end
    alias d down

    def origin x=nil, y=nil
      return unless check_sugarcube_view

      f = @sugarcube_view.frame
      return f.origin unless x

      if y
        f.origin.x = x
        f.origin.y = y
      else
        f.origin = SugarCube::CoreGraphics::Point(x)
      end
      @sugarcube_view.frame = f
      puts format_frame(f)

      @sugarcube_view
    end
    alias o origin

    ##|  SIZE
    def thinner(val=1)
      SugarCube::Repl::wider -val
    end
    alias n thinner

    def wider(val=1)
      return unless check_sugarcube_view

      f = @sugarcube_view.frame
      f.size.width += val
      @sugarcube_view.frame = f
      puts format_frame(f)

      @sugarcube_view
    end
    alias w wider

    def shorter(val=1)
      SugarCube::Repl::taller -val
    end
    alias s shorter

    def taller(val=1)
      return unless check_sugarcube_view

      f = @sugarcube_view.frame
      f.size.height += val
      @sugarcube_view.frame = f
      puts format_frame(f)

      @sugarcube_view
    end
    alias t taller

    def size(w=nil, h=nil)
      return unless check_sugarcube_view

      f = @sugarcube_view.frame
      return f.size unless w

      if h
        f.size.width = w
        f.size.height = h
      else
        f.size = SugarCube::CoreGraphics::Size(w)
      end
      @sugarcube_view.frame = f
      puts format_frame(f)

      @sugarcube_view
    end
    alias z size

    ##|  RESTORE
    def restore
      return unless check_sugarcube_view

      @sugarcube_restore.each do |msg, value|
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

      view = @sugarcube_view

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

    def get_tree_item(item)
      if item.nil? || item.is_a?(Fixnum)
        window(item)
      else
        item
      end
    end

    # @param item this can be a tree-like item (View, ViewController, CALayer,
    #     Menu) or an integer, in which case it will select that window.  Defalt
    #     is to display the keyWindow
    # @param selector If you pass an unsupported object to tree, you will need
    #     to pass a selector as well - this method should return an array of
    #     items which are passed recursively to tree
    # @block sel_blk If a block is passed, it will be used to build the array of
    #     items that are called recursively
    def tree(item=nil, selector=nil, &sel_blk)
      item = get_tree_item(item)

      if sel_blk && selector
        raise "You can't hand me a block AND a selector.  I don't know what to do with them!"
      elsif sel_blk
        selector = sel_blk
      elsif ! selector
        if item.is_a? CALayer
          selector = :sublayers
        elsif defined?(SKNode) && item.is_a?(SKNode)
          selector = :children
        else
          selector = get_tree_selector(item)
        end

        unless selector
          raise "Unable to determine a SugarCube::Repl::tree selector for #{item.class.to_s}"
        end
      end

      @sugarcube_items = SugarCube::Repl::build_tree(item, selector)
      if @sugarcube_collapsed_items
        @sugarcube_collapsed_items.keep_if { |v| @sugarcube_items.include? v }
      end
      if self.respond_to? :draw_tree
        draw_tree(item, selector)
      else
        SugarCube::Repl::draw_tree(item, selector)
      end
      puts ''

      return item
    end

    # Draws the tree items
    def draw_tree(item, selector, tab=nil, is_last=true, items_index=0)
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
        if @sugarcube_collapsed_items && @sugarcube_collapsed_items.include?(item)
          print '<<< '
        else
          if is_last
            print '`-- '
            tab += '    '
          else
            print '+-- '
            tab += '|   '
          end
        end
      else
        print '. '
        tab = ''
      end

      if self == item || @sugarcube_view == item
        print "\033[1m"
      end
      print draw_tree_item(item)
      if self == item || @sugarcube_view == item
        print "\033[0m"
      end
      puts

      if selector.is_a? Proc
        items = selector.call(item)
      else
        items = item.send(selector)
      end
      items ||= []

      unless @sugarcube_collapsed_items && @sugarcube_collapsed_items.include?(item)
        items.each_with_index do |subview, index|
          items_index += 1
          if self.respond_to? :draw_tree
            items_index = draw_tree(subview, selector, tab, index == items.length - 1, items_index)
          else
            items_index = SugarCube::Repl::draw_tree(subview, selector, tab, index == items.length - 1, items_index)
          end
        end
      end

      return items_index
    end

    def build_tree(item, selector)

      if selector.is_a? Proc
        items = selector.call(item)
      else
        items = item.send(selector)
      end
      items ||= []

      ret = [item]
      return ret if @sugarcube_collapsed_items && @sugarcube_collapsed_items.include?(item)

      items.each_with_index do |subview, index|
        ret.concat SugarCube::Repl::build_tree(subview, selector)
      end
      ret
    end

    def check_sugarcube_view
      raise 'no view has been assigned to SugarCube::Repl::adjust' unless @sugarcube_view

      true
    end

    def format_frame(frame)
      "[[#{frame.origin.x}, #{frame.origin.y}], [#{frame.size.width}, #{frame.size.height}]]"
    end

  end
end
