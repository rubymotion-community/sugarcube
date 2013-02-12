describe "SugarCube::CoreGraphics" do
  describe 'Point()' do
    it 'should accept 1 argument: a CGPoint' do
      cgpoint = CGPoint.new(1, 2)
      p = Point(cgpoint)
      p.x.should == 1
      p.y.should == 2
      CGPointEqualToPoint(p, cgpoint).should == true
    end

    it 'should accept 1 argument: a CGSize' do
      cgsize = CGSize.new(1, 2)
      p = Point(cgsize)
      p.x.should == 1
      p.y.should == 2
      CGPointEqualToPoint(p, CGPoint.new(cgsize.width, cgsize.height)).should == true
    end

    it 'should accept 1 argument: a UIOffset' do
      uioffset = UIOffset.new(1, 2)
      p = Point(uioffset)
      p.x.should == 1
      p.y.should == 2
      CGPointEqualToPoint(p, CGPoint.new(uioffset.horizontal, uioffset.vertical)).should == true
    end

    it 'should accept 1 argument: an Array' do
      array = [1, 2]
      p = Point(array)
      p.x.should == 1
      p.y.should == 2
      CGPointEqualToPoint(p, CGPoint.new(array[0], array[1])).should == true
    end

    it 'should accept 2 arguments: two numbers' do
      args = [1, 2]
      p = Point(*args)
      p.x.should == 1
      p.y.should == 2
      CGPointEqualToPoint(p, CGPoint.new(args[0], args[1])).should == true
    end
  end

  describe 'Size()' do
    it 'should accept 1 argument: a CGPoint' do
      cgpoint = CGPoint.new(1, 2)
      s = Size(cgpoint)
      s.width.should == 1
      s.height.should == 2
      CGSizeEqualToSize(s, CGSize.new(cgpoint.x, cgpoint.y)).should == true
    end

    it 'should accept 1 argument: a CGSize' do
      cgsize = CGSize.new(1, 2)
      s = Size(cgsize)
      s.width.should == 1
      s.height.should == 2
      CGSizeEqualToSize(s, cgsize).should == true
    end

    it 'should accept 1 argument: a UIOffset' do
      uioffset = UIOffset.new(1, 2)
      s = Size(uioffset)
      s.width.should == 1
      s.height.should == 2
      CGSizeEqualToSize(s, CGSize.new(uioffset.horizontal, uioffset.vertical)).should == true
    end

    it 'should accept 1 argument: an Array' do
      array = [1, 2]
      s = Size(array)
      s.width.should == 1
      s.height.should == 2
      CGSizeEqualToSize(s, CGSize.new(array[0], array[1])).should == true
    end

    it 'should accept 2 arguments: two numbers' do
      args = [1, 2]
      s = Size(*args)
      s.width.should == 1
      s.height.should == 2
      CGSizeEqualToSize(s, CGSize.new(args[0], args[1])).should == true
    end
  end

  describe 'Rect()' do
    it 'should accept 1 argument: a CGRect' do
      cgr = CGRect.new([1, 2], [3, 4])
      r = Rect(cgr)
      r.origin.x.should == 1
      r.origin.y.should == 2
      r.size.width.should == 3
      r.size.height.should == 4
      CGRectEqualToRect(r, cgr).should == true
    end

    it 'should accept 1 argument: a UIView' do
      uiview = UIView.alloc.initWithFrame([[1, 2], [3, 4]])
      r = Rect(uiview)
      r.origin.x.should == 1
      r.origin.y.should == 2
      r.size.width.should == 3
      r.size.height.should == 4
      CGRectEqualToRect(r, uiview.frame).should == true
    end

    it 'should accept 1 argument: a CALayer' do
      calayer = CALayer.alloc.init
      calayer.frame = [[1, 2], [3, 4]]
      r = Rect(calayer)
      r.origin.x.should == 1
      r.origin.y.should == 2
      r.size.width.should == 3
      r.size.height.should == 4
      CGRectEqualToRect(r, calayer.frame).should == true
    end

    it 'should accept 1 argument: an Array of 2 arrays' do
      array = [[1, 2], [3, 4]]
      r = Rect(array)
      r.origin.x.should == 1
      r.origin.y.should == 2
      r.size.width.should == 3
      r.size.height.should == 4
      CGRectEqualToRect(r, CGRect.new(array[0], array[1])).should == true
    end

    it 'should accept 1 argument: an Array of 4 numbers' do
      array = [1, 2, 3, 4]
      r = Rect(array)
      r.origin.x.should == 1
      r.origin.y.should == 2
      r.size.width.should == 3
      r.size.height.should == 4
      CGRectEqualToRect(r, CGRect.new([array[0], array[1]], [array[2], array[3]])).should == true
    end

    it 'should accept 2 arguments: (CGPoint, CGSize)' do
      args = [CGPoint.new(1, 2), CGSize.new(3, 4)]
      r = Rect(*args)
      r.origin.x.should == 1
      r.origin.y.should == 2
      r.size.width.should == 3
      r.size.height.should == 4
      CGRectEqualToRect(r, CGRect.new(args[0], args[1])).should == true
    end

    it 'should accept 2 arguments: (CGPoint, CGPoint)' do
      args = [CGPoint.new(1, 2), CGPoint.new(3, 4)]
      r = Rect(*args)
      r.origin.x.should == 1
      r.origin.y.should == 2
      r.size.width.should == 2
      r.size.height.should == 2
      CGRectEqualToRect(r, CGRect.new(args[0], [2, 2])).should == true
    end

    it 'should accept 3 arguments: ([x, y], w, h)' do
      args = [[1, 2], 3, 4]
      r = Rect(*args)
      r.origin.x.should == 1
      r.origin.y.should == 2
      r.size.width.should == 3
      r.size.height.should == 4
      CGRectEqualToRect(r, CGRect.new(args[0], [args[1], args[2]])).should == true
    end

    it 'should accept 3 arguments: (CGPoint, w, h)' do
      args = [CGPoint.new(1, 2), 3, 4]
      r = Rect(*args)
      r.origin.x.should == 1
      r.origin.y.should == 2
      r.size.width.should == 3
      r.size.height.should == 4
      CGRectEqualToRect(r, CGRect.new(args[0], [args[1], args[2]])).should == true
    end

    it 'should accept 3 arguments: (x, y, [w, h])' do
      args = [1, 2, [3, 4]]
      r = Rect(*args)
      r.origin.x.should == 1
      r.origin.y.should == 2
      r.size.width.should == 3
      r.size.height.should == 4
      CGRectEqualToRect(r, CGRect.new([args[0], args[1]], args[2])).should == true
    end

    it 'should accept 3 arguments: (x, y, CGSize)' do
      args = [1, 2, CGSize.new(3, 4)]
      r = Rect(*args)
      r.origin.x.should == 1
      r.origin.y.should == 2
      r.size.width.should == 3
      r.size.height.should == 4
      CGRectEqualToRect(r, CGRect.new([args[0], args[1]], args[2])).should == true
    end

    it 'should accept 4 arguments: 4 numbers' do
      args = [1, 2, 3, 4]
      r = Rect(*args)
      r.origin.x.should == 1
      r.origin.y.should == 2
      r.size.width.should == 3
      r.size.height.should == 4
      CGRectEqualToRect(r, CGRect.new([args[0], args[1]], [args[2], args[3]])).should == true
    end
  end

  describe 'Offset()' do
    it 'should accept 1 argument: a CGPoint' do
      cgpoint = CGPoint.new(1, 2)
      o = Offset(cgpoint)
      o.horizontal.should == 1
      o.vertical.should == 2
      UIOffsetEqualToOffset(o, UIOffset.new(cgpoint.x, cgpoint.y)).should == true
    end

    it 'should accept 1 argument: a CGSize' do
      cgsize = CGSize.new(1, 2)
      o = Offset(cgsize)
      o.horizontal.should == 1
      o.vertical.should == 2
      UIOffsetEqualToOffset(o, UIOffset.new(cgsize.width, cgsize.height)).should == true
    end

    it 'should accept 1 argument: a UIOffset' do
      uioffset = UIOffset.new(1, 2)
      o = Offset(uioffset)
      o.horizontal.should == 1
      o.vertical.should == 2
      UIOffsetEqualToOffset(o, uioffset).should == true
    end

    it 'should accept 1 argument: a Numeric' do
      numeric = 5
      o = Offset(numeric)
      o.horizontal.should == 5
      o.vertical.should == 5
      UIOffsetEqualToOffset(o, UIOffset.new(numeric, numeric)).should == true
    end
  end

  describe 'EdgeInsets()' do
    it 'should accept 1 argument: a CGRect' do
      cgrect = CGRect.new([1, 2], [3, 4])
      e = EdgeInsets(cgrect)
      e.left.should == 1
      e.top.should == 2
      e.right.should == 3
      e.bottom.should == 4
      UIEdgeInsetsEqualToEdgeInsets(e, UIEdgeInsets.new(cgrect.origin.y, cgrect.origin.x, cgrect.size.height, cgrect.size.width)).should == true
    end

    it 'should accept 1 argument: a UIEdgeInset' do
      uiedgeinsets = UIEdgeInsets.new(1, 2, 3, 4)
      e = EdgeInsets(uiedgeinsets)
      e.top.should == 1
      e.left.should == 2
      e.bottom.should == 3
      e.right.should == 4
      UIEdgeInsetsEqualToEdgeInsets(e, uiedgeinsets).should == true
    end

    it 'should accept 1 argument: a Numeric' do
      numeric = 5
      e = EdgeInsets(numeric)
      e.top.should == 5
      e.left.should == 5
      e.bottom.should == 5
      e.right.should == 5
      UIEdgeInsetsEqualToEdgeInsets(e, UIEdgeInsets.new(numeric, numeric, numeric, numeric)).should == true
    end

    it 'should accept 2 arguments: Numerics' do
      args = [5, 6]
      e = EdgeInsets(*args)
      e.top.should == 5
      e.left.should == 6
      e.bottom.should == 5
      e.right.should == 6
      UIEdgeInsetsEqualToEdgeInsets(e, UIEdgeInsets.new(args[0], args[1], args[0], args[1])).should == true
    end

    it 'should accept 3 arguments: Numerics' do
      args = [5, 6, 7]
      e = EdgeInsets(*args)
      e.top.should == 5
      e.left.should == 6
      e.bottom.should == 7
      e.right.should == 6
      UIEdgeInsetsEqualToEdgeInsets(e, UIEdgeInsets.new(args[0], args[1], args[2], args[1])).should == true
    end

    it 'should accept 4 arguments: Numerics' do
      args = [5, 6, 7, 8]
      e = EdgeInsets(*args)
      e.top.should == 5
      e.left.should == 6
      e.bottom.should == 7
      e.right.should == 8
      UIEdgeInsetsEqualToEdgeInsets(e, UIEdgeInsets.new(args[0], args[1], args[2], args[3])).should == true
    end
  end
end
