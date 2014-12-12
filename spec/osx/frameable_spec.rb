describe SugarCube::Frameable do

  describe NSView do

    it 'should return x' do
      view = NSView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.x.should == view.frame.origin.x
    end

    it 'should set x' do
      view = NSView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.x = 500
      view.x.should == 500
    end

    it 'should return y' do
      view = NSView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.y.should == view.frame.origin.y
    end

    it 'should set y' do
      view = NSView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.y = 500
      view.y.should == 500
    end

    it 'should return width' do
      view = NSView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.width.should == view.frame.size.width
    end

    it 'should set width' do
      view = NSView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.width = 500
      view.width.should == 500
    end

    it 'should return height' do
      view = NSView.alloc.initWithFrame([[100, 200], [300, 400]])
      view.height.should == view.frame.size.height
    end

    it 'should set height' do
      view = NSView.alloc.initWithFrame([[100, 200], [300, 400]])
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

  describe NSWindow do

    before do
      @window = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
            styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
            backing: NSBackingStoreBuffered,
            defer: false)
    end

    it 'should return x' do
      @window.x.should == @window.frame.origin.x
    end

    it 'should set x' do
      @window.x = 500
      @window.x.should == 500
    end

    it 'should return y' do
      @window.y.should == @window.frame.origin.y
    end

    it 'should set y' do
      @window.y = 500
      @window.y.should == 500
    end

    it 'should return width' do
      @window.width.should == @window.frame.size.width
    end

    it 'should set width' do
      @window.width = 500
      @window.width.should == 500
    end

    it 'should return height' do
      @window.height.should == @window.frame.size.height
    end

    it 'should set height' do
      @window.height = 500
      @window.height.should == 500
    end

  end

  describe NSScreen do

    it 'should return x' do
      view = NSScreen.alloc.initWithFrame([[100, 200], [300, 400]])
      view.x.should == view.frame.origin.x
    end

    it 'should return y' do
      view = NSScreen.alloc.initWithFrame([[100, 200], [300, 400]])
      view.y.should == view.frame.origin.y
    end

    it 'should return width' do
      view = NSScreen.alloc.initWithFrame([[100, 200], [300, 400]])
      view.width.should == view.frame.size.width
    end

    it 'should return height' do
      view = NSScreen.alloc.initWithFrame([[100, 200], [300, 400]])
      view.height.should == view.frame.size.height
    end

  end

end
