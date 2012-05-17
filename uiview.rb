

class UIView

  def <<(view)
    self.addSubview view
  end

  # i like this idea, but view[0] = view doesn't *look* like an insertion,
  # it lookes like a replacement... it should be written as
  #     view[0] += sub_view
  # or
  #     view[0] << sub_view
  # def []=(index, view)
  #   self.insertSubview(view, atIndex:index)
  # end

end
