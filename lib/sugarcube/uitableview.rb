class UITableView
  class << self
    def plain
      UITableView.alloc.initWithFrame([[0, 0], [320, 480]], style: :plain.uitableviewstyle)
    end
    def grouped
      UITableView.alloc.initWithFrame([[0, 0], [320, 480]], style: :grouped.uitableviewstyle)
    end
  end
end
