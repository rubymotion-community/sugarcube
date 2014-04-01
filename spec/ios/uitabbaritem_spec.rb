describe UITabBarItem do

  it 'should support `titled`' do
    item = UITabBarItem.titled('title')
    item.should.be.kind_of(UITabBarItem)
    item.title.should == 'title'
  end

  it 'should support `titled` with options' do
    item = UITabBarItem.titled('title',
      tag: 1,
      badge: 'test',
      image: UIImage.imageNamed('little_square'),
      selected_image: UIImage.imageNamed('little_square'),
      )
    item.should.be.kind_of(UITabBarItem)
    item.title.should == 'title'
    item.tag.should == 1
    item.badgeValue.should == 'test'
    item.image.should.be.kind_of(UIImage)
  end

  it 'should support `titled` with sugary options' do
    item = UITabBarItem.titled('title',
      tag: 1,
      badge: 'test',
      image: 'little_square',
      selected_image: 'little_square',
      )
    item.title.should == 'title'
    item.tag.should == 1
    item.badgeValue.should == 'test'
    item.image.should.be.kind_of(UIImage)
  end

  it 'should support `system`' do
    item = UITabBarItem.system(UITabBarSystemItemMore)
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `system` with options' do
    item = UITabBarItem.system(UITabBarSystemItemMore,
      tag: 1,
      badge: 'test',
      )
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `system` with sugar' do
    item = UITabBarItem.system(:more)
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `more`' do
    item = UITabBarItem.more
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `favorites`' do
    item = UITabBarItem.favorites
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `featured`' do
    item = UITabBarItem.featured
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `top_rated`' do
    item = UITabBarItem.top_rated
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `recents`' do
    item = UITabBarItem.recents
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `contacts`' do
    item = UITabBarItem.contacts
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `history`' do
    item = UITabBarItem.history
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `bookmarks`' do
    item = UITabBarItem.bookmarks
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `search`' do
    item = UITabBarItem.search
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `downloads`' do
    item = UITabBarItem.downloads
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `most_recent`' do
    item = UITabBarItem.most_recent
    item.should.be.kind_of(UITabBarItem)
  end

  it 'should support `most_viewed`' do
    item = UITabBarItem.most_viewed
    item.should.be.kind_of(UITabBarItem)
  end

end
