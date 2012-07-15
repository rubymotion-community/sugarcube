
UIView.teacup_handler :backgroundColor { |view, color|
  view.backgroundColor = color.uicolor
}

UIActivityIndicatorView.teacup_handler :color { |view, color|
  view.color = color.uicolor
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

UIButton.teacup_handler :normal { |view, img|
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

UIButton.teacup_handler :bg_normal { |view, img|
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

UIButton.teacup_handler :returnKeyType, :returnkey { |view, type|
  type = type.uireturnkey if Symbol === type
  view.setReturnKeyType(type)
}
