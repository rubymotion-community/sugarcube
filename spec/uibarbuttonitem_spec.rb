describe UIBarButtonItem do

  # with system item
  it 'should be :done' do
    b = UIBarButtonItem.done {
      @result = :done
    }
    b.target.send b.action, b
    @result.should == :done
  end
  
  it 'should be :cancel' do
    b = UIBarButtonItem.cancel {
      @result = :cancel
    }
    b.target.send b.action, b
    @result.should == :cancel
  end
  
  it 'should be :edit' do
    b = UIBarButtonItem.edit {
      @result = :edit
    }
    b.target.send b.action, b
    @result.should == :edit
  end
  
  it 'should be :save' do
    b = UIBarButtonItem.save {
      @result = :save
    }
    b.target.send b.action, b
    @result.should == :save
  end
  
  it 'should be :add' do
    b = UIBarButtonItem.add {
      @result = :add
    }
    b.target.send b.action, b
    @result.should == :add
  end
  
  it 'should be :flexiblespace' do
    b = UIBarButtonItem.flexiblespace {
      @result = :flexiblespace
    }
    b.target.send b.action, b
    @result.should == :flexiblespace
  end
  
  it 'should be :fixedspace' do
    b = UIBarButtonItem.fixedspace {
      @result = :fixedspace
    }
    b.target.send b.action, b
    @result.should == :fixedspace
  end
  
  it 'should be :compose' do
    b = UIBarButtonItem.compose {
      @result = :compose
    }
    b.target.send b.action, b
    @result.should == :compose
  end
  
  it 'should be :reply' do
    b = UIBarButtonItem.reply {
      @result = :reply
    }
    b.target.send b.action, b
    @result.should == :reply
  end
  
  it 'should be :action' do
    b = UIBarButtonItem.action {
      @result = :action
    }
    b.target.send b.action, b
    @result.should == :action
  end
  
  it 'should be :organize' do
    b = UIBarButtonItem.organize {
      @result = :organize
    }
    b.target.send b.action, b
    @result.should == :organize
  end
  
  it 'should be :bookmarks' do
    b = UIBarButtonItem.bookmarks {
      @result = :bookmarks
    }
    b.target.send b.action, b
    @result.should == :bookmarks
  end
  
  it 'should be :search' do
    b = UIBarButtonItem.search {
      @result = :search
    }
    b.target.send b.action, b
    @result.should == :search
  end
  
  it 'should be :refresh' do
    b = UIBarButtonItem.refresh {
      @result = :refresh
    }
    b.target.send b.action, b
    @result.should == :refresh
  end
  
  it 'should be :stop' do
    b = UIBarButtonItem.stop {
      @result = :stop
    }
    b.target.send b.action, b
    @result.should == :stop
  end
  
  it 'should be :camera' do
    b = UIBarButtonItem.camera {
      @result = :camera
    }
    b.target.send b.action, b
    @result.should == :camera
  end
  
  it 'should be :trash' do
    b = UIBarButtonItem.trash {
      @result = :trash
    }
    b.target.send b.action, b
    @result.should == :trash
  end
  
  it 'should be :play' do
    b = UIBarButtonItem.play {
      @result = :play
    }
    b.target.send b.action, b
    @result.should == :play
  end
  
  it 'should be :pause' do
    b = UIBarButtonItem.pause {
      @result = :pause
    }
    b.target.send b.action, b
    @result.should == :pause
  end
  
  it 'should be :rewind' do
    b = UIBarButtonItem.rewind {
      @result = :rewind
    }
    b.target.send b.action, b
    @result.should == :rewind
  end
  
  it 'should be :fastforward' do
    b = UIBarButtonItem.fastforward {
      @result = :fastforward
    }
    b.target.send b.action, b
    @result.should == :fastforward
  end
  
  it 'should be :undo' do
    b = UIBarButtonItem.undo {
      @result = :undo
    }
    b.target.send b.action, b
    @result.should == :undo
  end
  
  it 'should be :redo' do
    b = UIBarButtonItem.redo {
      @result = :redo
    }
    b.target.send b.action, b
    @result.should == :redo
  end
  
  it 'should be :pagecurl' do
    b = UIBarButtonItem.pagecurl {
      @result = :pagecurl
    }
    b.target.send b.action, b
    @result.should == :pagecurl
  end
  
  # with title
  it 'should be :titled' do
    b = UIBarButtonItem.titled('title') {
      @result = :titled
    }
    b.target.send b.action, b
    @result.should == :titled
  end
  
  it 'should be :titled_with_style' do
    b = UIBarButtonItem.titled('title', :plain.uibarbuttonstyle) {
      @result = :titled_with_style
    }
    b.target.send b.action, b
    @result.should == :titled_with_style
  end
  
  it 'should be :imaged' do
    b = UIBarButtonItem.imaged('little_square'.uiimage) {
      @result = :imaged
    }
    b.target.send b.action, b
    @result.should == :imaged
  end
  
  it 'should be :imaged_with_style' do
    b = UIBarButtonItem.imaged('little_square'.uiimage, :plain.uibarbuttonstyle) {
      @result = :imaged_with_style
    }
    b.target.send b.action, b
    @result.should == :imaged_with_style
  end

  it 'should be :imaged_with_images' do
    b = UIBarButtonItem.imaged(['little_square'.uiimage, 'little_square'.uiimage]) {
      @result = :imaged_with_images
    }
    b.target.send b.action, b
    @result.should == :imaged_with_images
  end
  
  
  
end
