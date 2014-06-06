describe 'NSString' do

  it "should have a #document_path method" do
    'foo'.document_path.should.start_with?('/Users')
    'foo'.document_path.should.end_with?('Documents/foo')
  end

  it "should have a #cache_path method" do
    'foo'.cache_path.should.start_with?('/Users')
    'foo'.cache_path.should.end_with?('Library/Caches/foo')
  end

  it "should have a #app_support_path method" do
    'foo'.app_support_path.should.start_with?('/Users')
    'foo'.app_support_path.should.end_with?('Library/Application Support/foo')
  end

  it "should have a #temporary_path method" do
    'foo'.temporary_path.should.start_with?('/Users')
    'foo'.temporary_path.should.end_with?('tmp/foo')
  end

  it "should have a resource_path method" do
    'little_square.png'.resource_path.should.start_with?("/Users")
    'little_square.png'.resource_path.should.end_with?("SugarCube_spec.app/little_square.png")
  end

  it "should have a resource_exists? method" do
    'little_square.png'.resource_exists?.should == true
    'foo'.resource_exists?.should == false
  end

  it "should have a #file_exists? method" do
    'foo'.document_path.file_exists?.should == false
  end

  it "should have a remove_file! method" do
    filename = 'remove_me'.document_path
    unless filename.file_exists?
      NSData.data.writeToFile(filename, atomically: true)
    end
    filename.remove_file!
    filename.file_exists?.should == false
  end

  describe "file_exists?" do

    it "should not file_exists" do
      "abc".file_exists?.should == false
    end

    it "should not file_exists" do
      "abc".cache_path.file_exists?.should == false
    end

    it "should not file_exists" do
      "abc".resource_path.file_exists?.should == false
    end

    describe "in document" do
      before do
        "abc".writeToFile "abc".document_path, atomically:true
      end
      after do
        NSFileManager.defaultManager.removeItemAtPath "abc".document_path, error:nil
      end

      it "should be file_exists" do
        "abc".file_exists?.should == true
      end
    end

    describe "in cache" do
      before do
        "abc".writeToFile "abc".cache_path, atomically:true
      end
      after do
        NSFileManager.defaultManager.removeItemAtPath "abc".cache_path, error:nil
      end

      it "should be file_exists" do
        "abc".cache_path.file_exists?.should == true
      end
    end

    describe "in resource" do
      it "should be file_exists" do
        "info.plist".resource_path.file_exists?.should == true
      end
    end

  end

  describe "remove_file!" do

    describe "in document" do
      before do
        "abc".writeToFile "abc".document_path, atomically:true
      end
      after do
        NSFileManager.defaultManager.removeItemAtPath "abc".document_path, error:nil
      end

      it "should remove" do
        "abc".remove_file!.should == nil
        "abc".file_exists?.should == false
      end
    end

    describe "in cache" do
      before do
        "abc".writeToFile "abc".cache_path, atomically:true
      end
      after do
        NSFileManager.defaultManager.removeItemAtPath "abc".cache_path, error:nil
      end

      it "should remove" do
        path = "abc".cache_path
        path.remove_file!.should == nil
        path.file_exists?.should == false
      end
    end

  end

  describe 'resource()' do
    describe '"info.plist".resource_path' do
      before { @it = "info.plist".resource_path }
      it 'should start with "/Users"' do
        @it.should.start_with?("/Users")
      end
      it 'should end with "SugarCube_spec.app/info.plist"' do
        @it.should.end_with?("SugarCube_spec.app/info.plist")
      end
    end

    describe '"PkgInfo".resource_path' do
      before { @it = "PkgInfo".resource_path }
      it 'should start with "/Users"' do
        @it.should.start_with?("/Users")
      end
      it 'should end with "SugarCube_spec.app/PkgInfo"' do
        @it.should.end_with?("SugarCube_spec.app/PkgInfo")
      end
    end
  end

  describe 'resource_url()' do
=begin
    # it fail. returns nil.
    # Maybe info.plist is not permitted to get as NSURL
    describe '"info.plist".resource_url' do
      before { @it = "info.plist".resource_url.absoluteString }
      it 'should start with "file://localhost/Users"' do
        @it.hasPrefix("file://localhost/Users").should == true
      end
      it 'should end with "SugarCube_spec.app/info.plist"' do
        @it.hasSuffix("SugarCube_spec.app/info.plist").should == true
      end
    end
=end

    describe '"PkgInfo".resource_url' do
      before { @it = "PkgInfo".resource_url.absoluteString }
      it 'should start with "file://localhost/Users"' do
        (
          @it.start_with?("file://localhost/Users") ||
          @it.start_with?("file:///Users")
        ).should == true
      end
      it 'should end with "SugarCube_spec.app/PkgInfo"' do
        @it.should.end_with?("SugarCube_spec.app/PkgInfo")
      end
    end
  end

  describe 'info_plist' do
    describe '"CFBundleVersion".info_plist' do
      before { @it = "CFBundleVersion".info_plist }
      it 'should be "1.0"' do
        @it.should == "1.0"
      end
    end

    describe '"CFBundleSupportedPlatforms".info_plist' do
      before { @it = "CFBundleSupportedPlatforms".info_plist }
      it 'should be ["iPhoneOS"]' do
        @it.should == ["iPhoneOS"]
      end
    end
  end

  describe 'file_url' do

    it 'should convert path String to NSURL' do
      'test'.resource_path.file_url.should.is_a?(NSURL)
    end

    it 'should be a file path' do
      'test'.resource_path.file_url.absoluteString.should.start_with?('file://')
    end

  end

end


describe 'NSString deprecated methods' do
  before do
    SugarCube::Legacy.log? true
  end

  after do
    SugarCube::Legacy.log? false
  end

  it "should have a #document method" do
    'foo'.document.should.start_with?('/Users')
    'foo'.document.should.end_with?('Documents/foo')
  end

  it "should have a #cache method" do
    'foo'.cache.should.start_with?('/Users')
    'foo'.cache.should.end_with?('Library/Caches/foo')
  end

  it "should have a #app_support method" do
    'foo'.app_support.should.start_with?('/Users')
    'foo'.app_support.should.end_with?('Library/Application Support/foo')
  end

  it "should have a #temporary method" do
    'foo'.temporary.should.start_with?('/Users')
    'foo'.temporary.should.end_with?('tmp/foo')
  end

  it "should have a resource method" do
    'little_square.png'.resource.should.start_with?("/Users")
    'little_square.png'.resource.should.end_with?("SugarCube_spec.app/little_square.png")
  end

  it "should have an #exists? method" do
    'foo'.document_path.exists?.should == false
  end

  it "should have a remove! method" do
    filename = 'remove_me'.document_path
    unless filename.file_exists?
      NSData.data.writeToFile(filename, atomically: true)
    end
    filename.remove!
    filename.file_exists?.should == false
  end

end
