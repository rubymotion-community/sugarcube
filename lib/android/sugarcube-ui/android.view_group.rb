module Android
  class ViewGroup

    def <<(view)
      addView(view)
    end

    def [](index)
      if index.is_a?(Numeric)
        getChildAt(index)
      end
    end

  end
end
