class UIImage

  # Operator shorthand for `apply_filter`, or coerces the image into other
  # formats.
  #
  # @example
  #   image = 'test'.uiimage
  #   new_image = image | CIFilter.gaussian_blur  # => returns a CIImage
  #   new_image = (image | CIFilter.gaussian_blur).uiimage  # => coerce to UIImage
  #   new_image = image | CIFilter.gaussian_blur | UIImage  # => coerce to UIImage via chaining
  def |(filter)
    if CIFilter === filter
      apply_filter(filter)
    elsif filter == UIImage
      self
    elsif filter == UIView || filter == UIImageView
      self.uiimageview
    elsif filter == CIImage
      ciimage
    elsif filter == UIColor
      uicolor
    elsif filter == NSData
      nsdata
    else
      raise "The `|` operator is not supported for the #{filter.is_a?(Class) ? filter.name : filter.class.name} class"
    end
  end

end


class UIView

   # Applies a filter (to a UIImage representation) or coerces to another format
   def |(filter)
    if filter == UIImage
      self.uiimage
    else
      raise "The `|` operator is not supported for the #{filter.is_a?(Class) ? filter.name : filter.class.name} class"
    end
   end

end


class CIImage

  def |(filter)
    if CIFilter === filter
      apply_filter(filter)
    elsif filter == UIImage
      self.uiimage
    elsif filter == UIView || filter == UIImageView
      self.uiimage.uiimageview
    elsif filter == CIImage
      self
    else
      raise "The `|` operator is not supported for the #{filter.is_a?(Class) ? filter.name : filter.class.name} class"
    end
  end

end


class String

  def |(filter)
    if Regexp === filter
      match = filter.match(self)
      match && match[0]
    elsif String === filter
      self.index(filter) && filter
    else
      raise "The `|` operator is not supported for the #{filter.is_a?(Class) ? filter.name : filter.class.name} class"
    end
  end

end
