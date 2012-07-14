
UIImageView.teacup_assign :image { |view, image|
  if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
    view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
  end
  view.image = image.uiimage
}

UIButton.teacup_assign :normal { |view, image|
  if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
    view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
  end
  view.setImage(image.uiimage, forState: UIControlStateNormal)
}

UIButton.teacup_assign :highlighted { |view, image|
  if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
    view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
  end
  view.setImage(image.uiimage, forState: UIControlStateHighlighted)
}

UIButton.teacup_assign :bg_normal { |view, image|
  if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
    view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
  end
  view.setBackgroundImage(image.uiimage, forState: UIControlStateNormal)
}

UIButton.teacup_assign :bg_highlighted { |view, image|
  if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
    view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
  end
  view.setBackgroundImage(image.uiimage, forState: UIControlStateHighlighted)
}

UIButton.teacup_assign :returnKeyType, :returnkey { |view, type|
  type = type.uireturnkey if Symbol === type
  view.setReturnKeyType(type)
}
