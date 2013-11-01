describe 'UIImage' do

  describe 'UIImage.canvas' do

    it 'should create an image' do
      UIImage.canvas(size: [10, 10]).should.is_a UIImage
    end

    it 'should have the right size' do
      CGSizeEqualToSize(UIImage.canvas(size: [10, 10]).size, [10, 10]).should == true
    end

    it 'should have the right scale' do
      UIImage.canvas(size: [10, 10], scale: 2).scale.should == 2
    end

    describe 'should have the right opacity' do
      it "should be opaque" do
        image = UIImage.canvas(size: [10, 10], scale: 2, opaque: true)
        image.color_at([0, 0]).alpha.should == 1
      end
      it "should be clear" do
        image = UIImage.canvas(size: [10, 10], scale: 2, opaque: false)
        image.color_at([0, 0]).alpha.should == 0
      end
    end

    it 'should draw an image' do
      image = UIImage.canvas(size: [10, 10], scale: 2) do |context|
        :red.uicolor.set
        CGContextAddRect(context, [[0, 0], [10, 10]])
        CGContextFillPath(context)
      end
      image.color_at([0, 0]).should == :red.uicolor
    end

  end

  describe '`<<` method should combine two images' do

    before do
      red = UIImage.canvas(size: [10, 10]) do |context|
        :red.uicolor.set
        CGContextAddRect(context, [[0, 0], [10, 10]])
        CGContextFillPath(context)
      end
      blue = UIImage.canvas(size: [10, 10]) do |context|
        :blue.uicolor.set
        CGContextAddRect(context, [[1, 1], [8, 8]])
        CGContextFillPath(context)
      end
      @img = (red << blue)
    end

    it 'should be red in the UL corner' do
      @img.color_at([0, 0]).should == :red.uicolor
    end
    it 'should be blue in the UL-inset corner' do
      @img.color_at([1, 1]).should == :blue.uicolor
    end
    it 'should be blue in the BR-inset corner' do
      @img.color_at([8, 8]).should == :blue.uicolor
    end
    it 'should be red in the BR corner' do
      @img.color_at([9, 9]).should == :red.uicolor
    end

  end

  describe '`merge` method should combine images' do

    describe 'should merge at top_left' do

      before do
        @red = UIImage.canvas(size: [10, 10]) do |context|
          :red.uicolor.set
          CGContextAddRect(context, [[0, 0], [10, 10]])
          CGContextFillPath(context)
        end
        @blue = UIImage.canvas(size: [8, 8]) do |context|
          :blue.uicolor.set
          CGContextAddRect(context, [[0, 0], [8, 8]])
          CGContextFillPath(context)
        end
        @img = @red.merge(@blue, at: :top_left)
      end

      it 'should work at top left corner' do
        @img.color_at([0, 0]).should == :blue.uicolor
      end
      it 'should work at top center' do
        @img.color_at([4, 0]).should == :blue.uicolor
      end
      it 'should work at top right corner' do
        @img.color_at([9, 0]).should == :red.uicolor
      end
      it 'should work at left side' do
        @img.color_at([0, 4]).should == :blue.uicolor
      end
      it 'should work at center' do
        @img.color_at([4, 4]).should == :blue.uicolor
      end
      it 'should work at right side' do
        @img.color_at([9, 4]).should == :red.uicolor
      end
      it 'should work at bottom left corner' do
        @img.color_at([0, 9]).should == :red.uicolor
      end
      it 'should work at bottom center' do
        @img.color_at([4, 9]).should == :red.uicolor
      end
      it 'should work at bottom right corner' do
        @img.color_at([9, 9]).should == :red.uicolor
      end
    end

    describe 'should merge at top' do
      before do
        @red = UIImage.canvas(size: [10, 10]) do |context|
          :red.uicolor.set
          CGContextAddRect(context, [[0, 0], [10, 10]])
          CGContextFillPath(context)
        end
        @blue = UIImage.canvas(size: [8, 8]) do |context|
          :blue.uicolor.set
          CGContextAddRect(context, [[0, 0], [8, 8]])
          CGContextFillPath(context)
        end
        @img = @red.merge(@blue, at: :top)
      end

      it 'should work at top left corner' do
        @img.color_at([0, 0]).should == :red.uicolor
      end
      it 'should work at top center' do
        @img.color_at([4, 0]).should == :blue.uicolor
      end
      it 'should work at top right corner' do
        @img.color_at([9, 0]).should == :red.uicolor
      end
      it 'should work at left side' do
        @img.color_at([0, 4]).should == :red.uicolor
      end
      it 'should work at center' do
        @img.color_at([4, 4]).should == :blue.uicolor
      end
      it 'should work at right side' do
        @img.color_at([9, 4]).should == :red.uicolor
      end
      it 'should work at bottom left corner' do
        @img.color_at([0, 9]).should == :red.uicolor
      end
      it 'should work at bottom center' do
        @img.color_at([4, 9]).should == :red.uicolor
      end
      it 'should work at bottom right corner' do
        @img.color_at([9, 9]).should == :red.uicolor
      end
    end

    describe 'should merge at top_right' do
      before do
        @red = UIImage.canvas(size: [10, 10]) do |context|
          :red.uicolor.set
          CGContextAddRect(context, [[0, 0], [10, 10]])
          CGContextFillPath(context)
        end
        @blue = UIImage.canvas(size: [8, 8]) do |context|
          :blue.uicolor.set
          CGContextAddRect(context, [[0, 0], [8, 8]])
          CGContextFillPath(context)
        end
        @img = @red.merge(@blue, at: :top_right)
      end

      it 'should work at top left corner' do
        @img.color_at([0, 0]).should == :red.uicolor
      end
      it 'should work at top center' do
        @img.color_at([4, 0]).should == :blue.uicolor
      end
      it 'should work at top right corner' do
        @img.color_at([9, 0]).should == :blue.uicolor
      end
      it 'should work at left side' do
        @img.color_at([0, 4]).should == :red.uicolor
      end
      it 'should work at center' do
        @img.color_at([4, 4]).should == :blue.uicolor
      end
      it 'should work at right side' do
        @img.color_at([9, 4]).should == :blue.uicolor
      end
      it 'should work at bottom left corner' do
        @img.color_at([0, 9]).should == :red.uicolor
      end
      it 'should work at bottom center' do
        @img.color_at([4, 9]).should == :red.uicolor
      end
      it 'should work at bottom right corner' do
        @img.color_at([9, 9]).should == :red.uicolor
      end
    end

    describe 'should merge at left' do
      before do
        @red = UIImage.canvas(size: [10, 10]) do |context|
          :red.uicolor.set
          CGContextAddRect(context, [[0, 0], [10, 10]])
          CGContextFillPath(context)
        end
        @blue = UIImage.canvas(size: [8, 8]) do |context|
          :blue.uicolor.set
          CGContextAddRect(context, [[0, 0], [8, 8]])
          CGContextFillPath(context)
        end
        @img = @red.merge(@blue, at: :left)
      end

      it 'should work at top left corner' do
        @img.color_at([0, 0]).should == :red.uicolor
      end
      it 'should work at top center' do
        @img.color_at([4, 0]).should == :red.uicolor
      end
      it 'should work at top right corner' do
        @img.color_at([9, 0]).should == :red.uicolor
      end
      it 'should work at left side' do
        @img.color_at([0, 4]).should == :blue.uicolor
      end
      it 'should work at center' do
        @img.color_at([4, 4]).should == :blue.uicolor
      end
      it 'should work at right side' do
        @img.color_at([9, 4]).should == :red.uicolor
      end
      it 'should work at bottom left corner' do
        @img.color_at([0, 9]).should == :red.uicolor
      end
      it 'should work at bottom center' do
        @img.color_at([4, 9]).should == :red.uicolor
      end
      it 'should work at bottom right corner' do
        @img.color_at([9, 9]).should == :red.uicolor
      end
    end

    describe 'should merge at center' do
      before do
        @red = UIImage.canvas(size: [10, 10]) do |context|
          :red.uicolor.set
          CGContextAddRect(context, [[0, 0], [10, 10]])
          CGContextFillPath(context)
        end
        @blue = UIImage.canvas(size: [8, 8]) do |context|
          :blue.uicolor.set
          CGContextAddRect(context, [[0, 0], [8, 8]])
          CGContextFillPath(context)
        end
        @img = @red.merge(@blue, at: :center)
      end

      it 'should work at top left corner' do
        @img.color_at([0, 0]).should == :red.uicolor
      end
      it 'should work at top center' do
        @img.color_at([4, 0]).should == :red.uicolor
      end
      it 'should work at top right corner' do
        @img.color_at([9, 0]).should == :red.uicolor
      end
      it 'should work at left side' do
        @img.color_at([0, 4]).should == :red.uicolor
      end
      it 'should work at center' do
        @img.color_at([4, 4]).should == :blue.uicolor
      end
      it 'should work at right side' do
        @img.color_at([9, 4]).should == :red.uicolor
      end
      it 'should work at bottom left corner' do
        @img.color_at([0, 9]).should == :red.uicolor
      end
      it 'should work at bottom center' do
        @img.color_at([4, 9]).should == :red.uicolor
      end
      it 'should work at bottom right corner' do
        @img.color_at([9, 9]).should == :red.uicolor
      end
    end

    describe 'should merge at right' do
      before do
        @red = UIImage.canvas(size: [10, 10]) do |context|
          :red.uicolor.set
          CGContextAddRect(context, [[0, 0], [10, 10]])
          CGContextFillPath(context)
        end
        @blue = UIImage.canvas(size: [8, 8]) do |context|
          :blue.uicolor.set
          CGContextAddRect(context, [[0, 0], [8, 8]])
          CGContextFillPath(context)
        end
        @img = @red.merge(@blue, at: :right)
      end

      it 'should work at top left corner' do
        @img.color_at([0, 0]).should == :red.uicolor
      end
      it 'should work at top center' do
        @img.color_at([4, 0]).should == :red.uicolor
      end
      it 'should work at top right corner' do
        @img.color_at([9, 0]).should == :red.uicolor
      end
      it 'should work at left side' do
        @img.color_at([0, 4]).should == :red.uicolor
      end
      it 'should work at center' do
        @img.color_at([4, 4]).should == :blue.uicolor
      end
      it 'should work at right side' do
        @img.color_at([9, 4]).should == :blue.uicolor
      end
      it 'should work at bottom left corner' do
        @img.color_at([0, 9]).should == :red.uicolor
      end
      it 'should work at bottom center' do
        @img.color_at([4, 9]).should == :red.uicolor
      end
      it 'should work at bottom right corner' do
        @img.color_at([9, 9]).should == :red.uicolor
      end
    end

    describe 'should merge at bottom_left' do
      before do
        @red = UIImage.canvas(size: [10, 10]) do |context|
          :red.uicolor.set
          CGContextAddRect(context, [[0, 0], [10, 10]])
          CGContextFillPath(context)
        end
        @blue = UIImage.canvas(size: [8, 8]) do |context|
          :blue.uicolor.set
          CGContextAddRect(context, [[0, 0], [8, 8]])
          CGContextFillPath(context)
        end
        @img = @red.merge(@blue, at: :bottom_left)
      end

      it 'should work at top left corner' do
        @img.color_at([0, 0]).should == :red.uicolor
      end
      it 'should work at top center' do
        @img.color_at([4, 0]).should == :red.uicolor
      end
      it 'should work at top right corner' do
        @img.color_at([9, 0]).should == :red.uicolor
      end
      it 'should work at left side' do
        @img.color_at([0, 4]).should == :blue.uicolor
      end
      it 'should work at center' do
        @img.color_at([4, 4]).should == :blue.uicolor
      end
      it 'should work at right side' do
        @img.color_at([9, 4]).should == :red.uicolor
      end
      it 'should work at bottom left corner' do
        @img.color_at([0, 9]).should == :blue.uicolor
      end
      it 'should work at bottom center' do
        @img.color_at([4, 9]).should == :blue.uicolor
      end
      it 'should work at bottom right corner' do
        @img.color_at([9, 9]).should == :red.uicolor
      end
    end

    describe 'should merge at bottom' do
      before do
        @red = UIImage.canvas(size: [10, 10]) do |context|
          :red.uicolor.set
          CGContextAddRect(context, [[0, 0], [10, 10]])
          CGContextFillPath(context)
        end
        @blue = UIImage.canvas(size: [8, 8]) do |context|
          :blue.uicolor.set
          CGContextAddRect(context, [[0, 0], [8, 8]])
          CGContextFillPath(context)
        end
        @img = @red.merge(@blue, at: :bottom)
      end

      it 'should work at top left corner' do
        @img.color_at([0, 0]).should == :red.uicolor
      end
      it 'should work at top center' do
        @img.color_at([4, 0]).should == :red.uicolor
      end
      it 'should work at top right corner' do
        @img.color_at([9, 0]).should == :red.uicolor
      end
      it 'should work at left side' do
        @img.color_at([0, 4]).should == :red.uicolor
      end
      it 'should work at center' do
        @img.color_at([4, 4]).should == :blue.uicolor
      end
      it 'should work at right side' do
        @img.color_at([9, 4]).should == :red.uicolor
      end
      it 'should work at bottom left corner' do
        @img.color_at([0, 9]).should == :red.uicolor
      end
      it 'should work at bottom center' do
        @img.color_at([4, 9]).should == :blue.uicolor
      end
      it 'should work at bottom right corner' do
        @img.color_at([9, 9]).should == :red.uicolor
      end
    end

    describe 'should merge at bottom_right' do
      before do
        @red = UIImage.canvas(size: [10, 10]) do |context|
          :red.uicolor.set
          CGContextAddRect(context, [[0, 0], [10, 10]])
          CGContextFillPath(context)
        end
        @blue = UIImage.canvas(size: [8, 8]) do |context|
          :blue.uicolor.set
          CGContextAddRect(context, [[0, 0], [8, 8]])
          CGContextFillPath(context)
        end
        @img = @red.merge(@blue, at: :bottom_right)
      end

      it 'should work at top left corner' do
        @img.color_at([0, 0]).should == :red.uicolor
      end
      it 'should work at top center' do
        @img.color_at([4, 0]).should == :red.uicolor
      end
      it 'should work at top right corner' do
        @img.color_at([9, 0]).should == :red.uicolor
      end
      it 'should work at left side' do
        @img.color_at([0, 4]).should == :red.uicolor
      end
      it 'should work at center' do
        @img.color_at([4, 4]).should == :blue.uicolor
      end
      it 'should work at right side' do
        @img.color_at([9, 4]).should == :blue.uicolor
      end
      it 'should work at bottom left corner' do
        @img.color_at([0, 9]).should == :red.uicolor
      end
      it 'should work at bottom center' do
        @img.color_at([4, 9]).should == :blue.uicolor
      end
      it 'should work at bottom right corner' do
        @img.color_at([9, 9]).should == :blue.uicolor
      end
    end

  end

  describe '`overlay` should add shading to an image' do

    it 'should return an image' do
      red = UIImage.canvas(size: [10, 10]) do |context|
        :red.uicolor.set
        CGContextAddRect(context, [[0, 0], [10, 10]])
        CGContextFillPath(context)
      end
      red.overlay(:white).should.is_a?(UIImage)
    end

    it 'should return an image that is the same size' do
      red = UIImage.canvas(size: [10, 10]) do |context|
        :red.uicolor.set
        CGContextAddRect(context, [[0, 0], [10, 10]])
        CGContextFillPath(context)
      end
      overlay = red.overlay(:white)
      overlay.size.width.should == red.size.width
      overlay.size.height.should == red.size.height
    end

    it 'should return an image that is a different color' do
      red = UIImage.canvas(size: [10, 10]) do |context|
        :red.uicolor.set
        CGContextAddRect(context, [[0, 0], [10, 10]])
        CGContextFillPath(context)
      end
      overlay = red.overlay(:white)
      overlay.color_at([0, 0]).should != red.color_at([0, 0])
    end

  end

end
