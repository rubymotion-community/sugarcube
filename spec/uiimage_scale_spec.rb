describe "UIImage scale methods" do
  before do
    @image = 'little_square'.uiimage
  end

  it 'should scale_to a wider size' do
    scaled = @image.scale_to([20, 10])
    scaled.nsdata.writeToFile('scale_to.png'.document, atomically: true)
    scaled.size.width.should == 20
    scaled.size.height.should == 10
  end

  it 'should scale_to a taller size' do
    scaled = @image.scale_to([10, 20])
    scaled.nsdata.writeToFile('scale_to.png'.document, atomically: true)
    scaled.size.width.should == 10
    scaled.size.height.should == 20
  end

  it 'scale_to should support background' do
    scaled = @image.scale_to([20, 10], background: :blue.uicolor)
    scaled.nsdata.writeToFile('scale_to_background.png'.document, atomically: true)
    scaled.size.width.should == 20
    scaled.size.height.should == 10
  end

  it 'should scale_within a smaller size' do
    scaled = @image.scale_within([5, 10])
    scaled.nsdata.writeToFile('scale_within_smaller.png'.document, atomically: true)
    scaled.size.width.should == 5
    scaled.size.height.should == 5
  end

  it 'should scale_within a bigger size' do
    scaled = @image.scale_within([15, 20])
    scaled.nsdata.writeToFile('scale_within_bigger.png'.document, atomically: true)
    scaled.size.width.should == 15
    scaled.size.height.should == 15
  end

  it 'should scale_to_fill a wider size' do
    scaled = @image.scale_to_fill([20, 10])
    scaled.nsdata.writeToFile('scale_to_fill.png'.document, atomically: true)
    scaled.size.width.should == 20
    scaled.size.height.should == 10
    scaled.scale.should == @image.scale
  end

  it 'scale_to_fill should support position' do
    scaled = @image.scale_to_fill([10, 20], position: :top_left)
    scaled.nsdata.writeToFile('scale_to_fill_position_top_left.png'.document, atomically: true)
    scaled = @image.scale_to_fill([20, 10], position: :top)
    scaled.nsdata.writeToFile('scale_to_fill_position_top.png'.document, atomically: true)
    scaled = @image.scale_to_fill([10, 20], position: :top_right)
    scaled.nsdata.writeToFile('scale_to_fill_position_top_right.png'.document, atomically: true)
    scaled = @image.scale_to_fill([10, 20], position: :left)
    scaled.nsdata.writeToFile('scale_to_fill_position_left.png'.document, atomically: true)
    scaled = @image.scale_to_fill([20, 10], position: :center)
    scaled.nsdata.writeToFile('scale_to_fill_position_center.png'.document, atomically: true)
    scaled = @image.scale_to_fill([10, 20], position: :right)
    scaled.nsdata.writeToFile('scale_to_fill_position_right.png'.document, atomically: true)
    scaled = @image.scale_to_fill([10, 20], position: :bottom_left)
    scaled.nsdata.writeToFile('scale_to_fill_position_bottom_left.png'.document, atomically: true)
    scaled = @image.scale_to_fill([20, 10], position: :bottom)
    scaled.nsdata.writeToFile('scale_to_fill_position_bottom.png'.document, atomically: true)
    scaled = @image.scale_to_fill([10, 20], position: :bottom_right)
    scaled.nsdata.writeToFile('scale_to_fill_position_bottom_right.png'.document, atomically: true)
    scaled.size.width.should == 10
    scaled.size.height.should == 20
  end

  it 'should be able to change scale' do
    if UIScreen.mainScreen.scale == 2
      scaled = @image.at_scale(1.0)
      scaled.nsdata.writeToFile('at_scale.png'.document, atomically: true)

      scaled.size.width.should == 20
      scaled.size.height.should == 20
      scaled.scale.should == 1
    else
      scaled = @image.at_scale(2.0)
      scaled.nsdata.writeToFile('at_scale.png'.document, atomically: true)

      scaled.size.width.should == 5
      scaled.size.height.should == 5
      scaled.scale.should == 2
    end
  end

end
