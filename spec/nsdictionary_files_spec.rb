describe 'NSDictionary' do

  before do
    @file_name = 'write_to_file.plist'.temporary_path
    @url = NSURL.alloc.initFileURLWithPath 'write_to_file.plist'.temporary_path
  end

  describe 'writing to a file' do
    it 'should write {} to a file' do
      subject = {}
      subject.write_to(@file_name).should == true
      @file_name.file_exists?.should == true
    end

    it 'should write {...} to a url' do
      subject = { 'a' => 1, 'b' => 2, 'c' => 3 }
      subject.write_to(@url).should == true
      @file_name.file_exists?.should == true
    end

    it 'should write {...} with nested objects to a file' do
      subject = { 'a' => 1, 'b' => 2, 'c' => { 'd' => 3, 'true' => true, 'false' => false, 'empty_string' => "", 'empty_dictionary' => {}}}
      subject.write_to(@file_name).should == true
      @file_name.file_exists?.should == true
    end

    it 'should write {...} with symbols to a file' do
      subject = { a: 1, b: 2, c: 3 }
      subject.write_to(@file_name).should == true
      @file_name.file_exists?.should == true
    end
  end

  describe 'reading from a file' do

    it 'should read {} from a file' do
      subject = {}
      subject.write_to(@file_name).should == true
      contents = NSDictionary.read_from(@file_name)
      contents.should == subject
    end

    it 'should read {...} from a file' do
      subject = { 'a' => 1, 'b' => 2, 'c' => 3 }
      subject.write_to(@file_name).should == true
      contents = NSDictionary.read_from(@file_name)
      contents.should == subject
    end

    it 'should read {...} with nested objects from a file' do
      subject = { 'a' => 1, 'b' => 2, 'c' => { 'd' => 3, 'true' => true, 'false' => false, 'empty_string' => "", 'empty_dictionary' => {}}}
      subject.write_to(@file_name).should == true
      contents = NSDictionary.read_from(@file_name)
      contents.should == subject
    end

    it 'should read {...} with symbols from a file' do
      subject = { a: 1, b: 2, c: 3 }
      read_contents = { 'a' => 1, 'b' => 2, 'c' => 3 }
      subject.write_to(@file_name).should == true
      contents = NSDictionary.read_from(@file_name)
      contents.should == read_contents
    end

    it 'should not have a file called "wtf is this"' do
      'wtf is this'.document_path.file_exists?.should == false
    end

    it 'should return nil for files that don\'t exist' do
      file_name = 'wtf is this'.document_path
      contents = NSDictionary.read_from(file_name)
      contents.should == nil
    end

  end

end
