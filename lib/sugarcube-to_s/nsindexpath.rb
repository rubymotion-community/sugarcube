class NSIndexPath

  def to_s
    return super unless self.respond_to?(:to_a)

    "<NSIndexPath #{to_a.to_s}>"
  end

end
