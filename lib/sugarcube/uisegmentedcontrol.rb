class UISegmentedControl
  class << self
    def plain(items)
      ret = self.alloc.initWithItems(items)
      ret.segmentedControlStyle = :plain.uisegmentedstyle
      ret
    end

    def bordered(items)
      ret = self.alloc.initWithItems(items)
      ret.segmentedControlStyle = :bordered.uisegmentedstyle
      ret
    end

    def bar(items)
      ret = self.alloc.initWithItems(items)
      ret.segmentedControlStyle = :bar.uisegmentedstyle
      ret
    end

    def bezeled(items)
      ret = self.alloc.initWithItems(items)
      ret.segmentedControlStyle = :bezeled.uisegmentedstyle
      ret
    end
  end
end
