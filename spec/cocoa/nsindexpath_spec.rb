describe NSIndexPath do

  it 'should have to_a' do
    path = NSIndexPath.indexPathWithIndex(1).indexPathByAddingIndex(3)
    path.to_a.should == [1, 3]
  end

  it 'should have to_ary' do
    a, b = NSIndexPath.indexPathWithIndex(1).indexPathByAddingIndex(3)
    a.should == 1
    b.should == 3
  end

  it 'should support indexPathForRow(inSection:)' do
    path = NSIndexPath.indexPathForRow(1, inSection: 3).to_a
    path[0].should == 3
    path[1].should == 1
  end

  it 'should support indexPathForItem(inSection:)' do
    path = NSIndexPath.indexPathForItem(1, inSection: 3).to_a
    path[0].should == 3
    path[1].should == 1
  end

end
