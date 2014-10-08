module SugarCube
  class Repl
    class << self

      @adjust_item = nil
      @tree_items = nil
      @collapsed_items = nil
      @restore = nil

      def adjust(item=nil)
        return @adjust_item unless item

        if item.is_a? Fixnum
          @tree_items ||= build_default_tree
          item = @tree_items[item]
        end

        # a/adjust will return this object
        @adjust_item = item

        adjust_init(item)

        item
      end

      def collapse(item)
        if item.is_a? Fixnum
          @tree_items ||= build_default_tree
          item = @tree_items[item]
        end

        @collapsed_items ||= []
        if @collapsed_items.include?(item)
          @collapsed_items.delete(item)
        else
          @collapsed_items << item
        end

        retval = tree

        if @collapsed_items
          @collapsed_items.keep_if { |v| @tree_items.include? v }
        end

        retval
      end

      def set_default(item)
        @default = item
      end

      def clear_default
        @default = nil
      end

      def register_tree_selector(klass, selector=nil, &sel_blk)
        if selector && sel_blk
          raise "You can't hand me a block AND a selector.  I don't know what to do with both!"
        end
        tree_selectors[klass] = selector || sel_blk
      end

      def tree_selectors(klass=nil)
        if ! @tree_selectors
          @tree_selectors ||= {}
          @tree_selectors[nil.class] = -> { nil }
          register_default_tree_selectors
        end

        if klass
          @tree_selectors[klass]
        else
          @tree_selectors
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
        if selector || sel_blk
          register_tree_selector(item.class, selector, &sel_blk)
        end

        @tree_items = build_tree(item)
        if @collapsed_items
          @collapsed_items.keep_if { |v| @tree_items.include? v }
        end
        draw_tree(item)
        puts ''

        return item
      end

      def draw_tree(item, tab=nil, is_last=true, items_index=0)
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
          if @collapsed_items && @collapsed_items.include?(item)
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

        if self == item || @adjust_item == item
          print "\033[1m"
        end
        print draw_tree_item(item)
        if self == item || @adjust_item == item
          print "\033[0m"
        end
        puts

        items = call_item_selector(item)

        unless @collapsed_items && @collapsed_items.include?(item)
          items.each_with_index do |subitem, index|
            items_index += 1
            if self.respond_to? :draw_tree
              items_index = draw_tree(subitem, tab, index == items.length - 1, items_index)
            else
              items_index = draw_tree(subitem, tab, index == items.length - 1, items_index)
            end
          end
        end

        return items_index
      end

      def build_tree(item)
        items = call_item_selector(item)

        ret = [item]
        return ret if @collapsed_items && @collapsed_items.include?(item)

        items.each_with_index do |subitem, index|
          ret.concat build_tree(subitem)
        end
        ret
      end

      def call_item_selector(item)
        selector = nil
        klass = item.class
        while klass && !selector
          selector = tree_selectors(klass)
          klass = klass.superclass
        end

        if !selector
          raise "Unable to determine a SugarCube::Repl::tree selector for #{item.class.to_s}"
        end

        if selector.is_a? Proc
          items = selector.call(item)
        else
          items = item.send(selector)
        end

        return items || []
      end

    end
  end
end
