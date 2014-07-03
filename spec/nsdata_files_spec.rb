describe 'NSData' do

  before do
    @file_name = 'write_to_file'.temporary_path
    @url = NSURL.alloc.initFileURLWithPath 'write_to_file'.temporary_path
  end

  describe 'writing to a file' do
    it 'should write data to a file' do
      subject = 'data'.dataUsingEncoding(NSUTF8StringEncoding)
      subject.write_to(@file_name).should == true
      @file_name.file_exists?.should == true
    end
  end

  describe 'writing to a url' do
    it 'should write data to a url' do
      subject = 'data'.dataUsingEncoding(NSUTF8StringEncoding)
      subject.write_to(@url).should == true
      @file_name.file_exists?.should == true
    end
  end

  describe 'reading from a file' do

    it 'should read data from a file' do
      subject = 'data'.dataUsingEncoding(NSUTF8StringEncoding)
      subject.write_to(@file_name).should == true
      contents = NSData.read_from(@file_name)
      contents.should == subject
    end

    it 'should not have a file called "wtf is this"' do
      'wtf is this'.document_path.file_exists?.should == false
    end

    it 'should return nil for files that don\'t exist' do
      file_name = 'wtf is this'.document_path
      contents = NSData.read_from(file_name)
      contents.should == nil
    end

  end

end
