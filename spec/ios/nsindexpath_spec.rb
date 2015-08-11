describe NSIndexPath do

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
