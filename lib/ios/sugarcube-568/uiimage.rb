class UIImage
  class << self
    SugarCube568_TallSuffix = '-568h@2x'  # 320 x 568
    SugarCube667_TallSuffix = '-667h@2x'  # 375 x 667
    SugarCube736_TallSuffix = '-736h@2x'  # 414 x 736

    def sugarcube568_imageNamed(name)
      case UIScreen.mainScreen.bounds.size.height
      when 568
        taller_image_ext = SugarCube568_TallSuffix
      when 667
        taller_image_ext = SugarCube667_TallSuffix
      when 736
        taller_image_ext = SugarCube736_TallSuffix
      else
        taller_image_ext = false
      end

      if ( taller_image_ext && name.length > 0 && name.rangeOfString(taller_image_ext).location == NSNotFound )
        # Check if is there a path extension or not
        test_name = name
        if test_name.pathExtension.length > 0
          test_name = test_name.stringByDeletingPathExtension.stringByAppendingString(taller_image_ext).stringByAppendingPathExtension(name.pathExtension)
        else
          test_name = test_name.stringByAppendingString(taller_image_ext)
        end

        return imageNamed_old(test_name)
      end

      return nil
    end

    alias :imageNamed_old :imageNamed
    # now we've got sugarcube568_imageNamed and imageNamed_old to load the respective versions

    def imageNamed(name)
      sugarcube568_imageNamed(name) || imageNamed_old(name)
    end
  end
end
