class UISegmentedControl
  class << self
    def plain(items)
      ret = self.alloc.initWithItems(items)
      ret.segmentedControlStyle = UISegmentedControlStylePlain
      ret
    end

    def bordered(items)
      ret = self.alloc.initWithItems(items)
      ret.segmentedControlStyle = UISegmentedControlStyleBordered
      ret
    end

    def bar(items)
      ret = self.alloc.initWithItems(items)
      ret.segmentedControlStyle = UISegmentedControlStyleBar
      ret
    end

    def bezeled(items)
      ret = self.alloc.initWithItems(items)
      ret.segmentedControlStyle = UISegmentedControlStyleBezeled
      ret
    end
  end
end
