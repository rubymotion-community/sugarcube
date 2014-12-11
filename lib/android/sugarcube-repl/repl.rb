module SugarCube
  class << Repl

    def build_default_tree
      build_tree(@default)
    end

    def adjust_init(item)
      if item.is_a?(Android::View)
        @restore = {}
      end
    end

    def register_default_tree_selectors
      register_tree_selector(Android::ViewLayout) do |view|
        views = []
        item.getChildCount.times do |index|
          views << item.getChildAt(index)
        end
        views
      end
      register_tree_selector(Android::View) { |view| [view] }
    end

    def draw_tree_item(item)
      item.to_s
    end

    def get_tree_item(item)
      if item.nil?
        @default
      else
        item
      end
    end

    def format_frame(frame)
      "[[#{frame.origin.x}, #{frame.origin.y}], [#{frame.size.width}, #{frame.size.height}]]"
    end

  end
end
