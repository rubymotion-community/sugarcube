describe SugarCube::Frameable do

  describe UIView do

    it 'should return x' do
      view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.x.should == view.frame.origin.x
    end

    it 'should set x' do
      view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.x = 500
      view.x.should == 500
    end

    it 'should return y' do
      view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.y.should == view.frame.origin.y
    end

    it 'should set y' do
      view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.y = 500
      view.y.should == 500
    end

    it 'should return width' do
      view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.width.should == view.frame.size.width
    end

    it 'should set width' do
      view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.width = 500
      view.width.should == 500
    end

    it 'should return height' do
      view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.height.should == view.frame.size.height
    end

    it 'should set height' do
      view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.height = 500
      view.height.should == 500
    end

  end

  describe CALayer do

    it 'should return x' do
      layer = CALayer.layer
      layer.frame = [[100, 200], [300, 400]]
      layer.x.should == layer.frame.origin.x
    end

    it 'should set x' do
      layer = CALayer.layer
      layer.frame = [[100, 200], [300, 400]]
      layer.x = 500
      layer.x.should == 500
    end

    it 'should return y' do
      layer = CALayer.layer
      layer.frame = [[100, 200], [300, 400]]
      layer.y.should == layer.frame.origin.y
    end

    it 'should set y' do
      layer = CALayer.layer
      layer.frame = [[100, 200], [300, 400]]
      layer.y = 500
      layer.y.should == 500
    end

    it 'should return width' do
      layer = CALayer.layer
      layer.frame = [[100, 200], [300, 400]]
      layer.width.should == layer.frame.size.width
    end

    it 'should set width' do
      layer = CALayer.layer
      layer.frame = [[100, 200], [300, 400]]
      layer.width = 500
      layer.width.should == 500
    end

    it 'should return height' do
      layer = CALayer.layer
      layer.frame = [[100, 200], [300, 400]]
      layer.height.should == layer.frame.size.height
    end

    it 'should set height' do
      layer = CALayer.layer
      layer.frame = [[100, 200], [300, 400]]
      layer.height = 500
      layer.height.should == 500
    end

  end
end
