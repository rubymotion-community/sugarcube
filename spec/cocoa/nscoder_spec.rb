class CoderHelper
  def initWithCoder(coder)
    self
  end

  def encodeWithCoder(coder)
  end

end

class CoderTester
  attr :object
  attr :bool
  attr :double
  attr :float
  attr :int
  attr :point
  attr :rect
  attr :size

  def initialize
    @object = CoderHelper.new
    @bool = true
    @double = 1.5
    @float = 1.5
    @int = 1
    @point = CGPoint.new(0, 0)
    @rect = CGRect.new([1, 1], [1, 1])
    @size = CGSize.new(2, 2)
  end

  def initWithCoder(coder)
    @object = coder['object']
    @bool = coder.bool('bool')
    @double = coder.double('double')
    @float = coder.float('float')
    @int = coder.int('int')
    @point = coder.point('point')
    @rect = coder.rect('rect')
    @size = coder.size('size')
    self
  end

  def encodeWithCoder(coder)
    coder['object'] = @object
    coder.set('bool', toBool:@bool)
    coder.set('double', toDouble:@double)
    coder.set('float', toFloat:@float)
    coder.set('int', toInt:@int)
    coder.set('point', toPoint:@point)
    coder.set('rect', toRect:@rect)
    coder.set('size', toSize:@size)
  end
end

describe "NSCoder" do

  before do
    @subject = CoderTester.new
  end

  it "is nscoding compliant" do
    data = NSCoder.archive(@subject)
    test = NSCoder.unarchive(data)
    test.object.class.should == CoderHelper
    test.bool.should == @subject.bool
    test.double.should == @subject.double
    test.float.should == @subject.float
    test.int.should == @subject.int
    val = test.point
    val.x.should == @subject.point.x
    val.y.should == @subject.point.y
    val = test.rect
    val.origin.x.should == @subject.rect.origin.x
    val.origin.y.should == @subject.rect.origin.y
    val.size.width.should == @subject.rect.size.width
    val.size.height.should == @subject.rect.size.height
    val = test.size
    val.width.should == @subject.size.width
    val.height.should == @subject.size.height
  end

end
