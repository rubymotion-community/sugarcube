
class View

  # aliases 'viewWithStylename', and provides indexed access to subviews
  #
  # Examples:
  #
  #     view[3]  # => view.subviews[3]
  #     view["button"]  # => view.viewWithStylename("button")
  def [] name
    if name.is_a? Fixnum
      return self.subviews[name]
    else
      return self.viewWithStylename(name)
    end
    nil
  end

end
