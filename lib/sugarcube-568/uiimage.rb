class UIImage
  class << self
    SugarCube568_TallSuffix = '-568h@2x'

    alias :imageNamed_old :imageNamed
    def imageNamed(name)
      @may_use_taller_images ||= CGSizeEqualToSize(CGSizeMake(320, 568), UIScreen.mainScreen.bounds.size)
      if ( @may_use_taller_images && name.length > 0  && name.rangeOfString(SugarCube568_TallSuffix).location == NSNotFound )
        # Check if is there a path extension or not
        test_name = name;
        if test_name.pathExtension.length > 0
          test_name = test_name.stringByDeletingPathExtension.stringByAppendingString(SugarCube568_TallSuffix).stringByAppendingPathExtension(name.pathExtension)
        else
          test_name = test_name.stringByAppendingString(SugarCube568_TallSuffix + ".png")
        end

        image = imageNamed_old(test_name)
        if image
          return self.imageWithCGImage(image.CGImage, scale:2.0, orientation:image.imageOrientation)
        end
      end

      imageNamed_old(name)
    end
  end
end
