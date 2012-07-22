# please organize by hierarchy and alphabetically, double spaces between classes

UIView.teacup_handler :backgroundColor { |view, color|
  view.backgroundColor = color.uicolor
}

UIView.teacup_handler :shadow { |view, shadow|
  {
    opacity: :'shadowOpacity=',
    radius: :'shadowRadius=',
    offset: :'shadowOffset=',
    color: :'shadowColor=',
    path: :'shadowPath=',
  }.each { |key, msg|
    if value = shadow[key]
      if key == :color
        value = value.uicolor.CGColor
      end
      NSLog "Setting layer.#{msg} = #{value.inspect}" if view.respond_to? :debug and view.debug
      view.layer.send(msg, value)
      view.layer.masksToBounds = false
      view.layer.shouldRasterize = true
    end
  }
}


UIActivityIndicatorView.teacup_handler :color { |view, color|
  view.color = color.uicolor
}

UIActivityIndicatorView.teacup_handler :style { |view, style|
  style = style.uiactivityindicatorstyle unless style.is_a?(Fixnum)
  view.activityIndicatorViewStyle = style
}
UIActivityIndicatorView.teacup_alias :activityIndicatorViewStyle => :style


UIButton.teacup_handler :normal, :image { |view, img|
  image = img.uiimage
  if not image
    NSLog("WARN: Could not find #{img.inspect}")
    return
  end
  raise "Expected UIImage in teacup_handler :image, not #{image.inspect}" unless image.is_a?(UIImage)

  if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
    view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
  end
  view.setImage(image, forState: UIControlStateNormal)
}

UIButton.teacup_handler :highlighted { |view, img|
  image = img.uiimage
  if not image
    NSLog("WARN: Could not find #{img.inspect}")
    return
  end
  raise "Expected UIImage in teacup_handler :image, not #{image.inspect}" unless image.is_a?(UIImage)

  if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
    view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
  end
  view.setImage(image, forState: UIControlStateHighlighted)
}

UIButton.teacup_handler :disabled { |view, img|
  image = img.uiimage
  if not image
    NSLog("WARN: Could not find #{img.inspect}")
    return
  end
  raise "Expected UIImage in teacup_handler :image, not #{image.inspect}" unless image.is_a?(UIImage)

  if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
    view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
  end
  view.setImage(image, forState: UIControlStateDisabled)
}

UIButton.teacup_handler :bg_normal, :bg_image { |view, img|
  image = img.uiimage
  if not image
    NSLog("WARN: Could not find #{img.inspect}")
    return
  end
  raise "Expected UIImage in teacup_handler :image, not #{image.inspect}" unless image.is_a?(UIImage)

  if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
    view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
  end
  view.setBackgroundImage(image, forState: UIControlStateNormal)
}

UIButton.teacup_handler :bg_highlighted { |view, img|
  image = img.uiimage
  if not image
    NSLog("WARN: Could not find #{img.inspect}")
    return
  end
  raise "Expected UIImage in teacup_handler :image, not #{image.inspect}" unless image.is_a?(UIImage)

  if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
    view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
  end
  view.setBackgroundImage(image, forState: UIControlStateHighlighted)
}

UIButton.teacup_handler :bg_disabled { |view, img|
  image = img.uiimage
  if not image
    NSLog("WARN: Could not find #{img.inspect}")
    return
  end
  raise "Expected UIImage in teacup_handler :image, not #{image.inspect}" unless image.is_a?(UIImage)

  if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
    view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
  end
  view.setBackgroundImage(image, forState: UIControlStateDisabled)
}

UIButton.teacup_handler :returnKeyType, :returnkey { |view, type|
  type = type.uireturnkey if Symbol === type
  view.setReturnKeyType(type)
}


UIImageView.teacup_handler :image { |view, img|
  image = img.uiimage
  if not image
    NSLog("WARN: Could not find #{img.inspect}")
    return
  end
  raise "Expected UIImage in teacup_handler :image, not #{image.inspect}" unless image.is_a?(UIImage)

  if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
    view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
  end
  view.image = image
}


UILabel.teacup_handler :textColor { |view, color|
  view.textColor = color.uicolor
}


UINavigationBar.teacup_handler :backgroundImage { |view, styles|
  styles.each do |metric, image|
    metric = metric.uibarmetrics if Symbol === metric
    view.setBackgroundImage(image.uiimage, forBarMetrics:metric)
  end
}


UITextField.teacup_handler :keyboardType { |view, type|
  type = type.uikeyboardtype unless type.is_a?(Fixnum)
  view.setKeyboardType type
}
