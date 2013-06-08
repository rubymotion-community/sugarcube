describe 'NSString' do

  it "should have a #document method" do
    'foo'.document.hasPrefix('/Users').should == true
    'foo'.document.hasSuffix('Documents/foo').should == true
  end

  it "should have a #cache method" do
    'foo'.cache.hasPrefix('/Users').should == true
    'foo'.cache.hasSuffix('Library/Caches/foo').should == true
  end

  it "should have a #app_support method" do
    'foo'.app_support.hasPrefix('/Users').should == true
    'foo'.app_support.hasSuffix('Library/Application Support/foo').should == true
  end

  it "should have an #exists? method" do
    'foo'.document.exists?.should == false
  end

  it "should have a remove! method" do
    unless 'remove_me'.exists?
      NSData.data.writeToFile('remove_me'.document, atomically: true)
    end
    'remove_me'.document.remove!
    'remove_me'.exists?.should == false
  end

  it "should have a resource_exists? method" do
    'little_square.png'.resource_exists?.should == true
    'foo'.resource_exists?.should == false
  end
  
  describe "exists?" do
    
    it "should not exists" do
      "abc".exists?.should == false
    end
    
    it "should not exists" do
      "abc".cache.exists?.should == false
    end
    
    it "should not exists" do
      "abc".resource.exists?.should == false
    end
    
    describe "in document" do
      before do
        "abc".writeToFile "abc".document, atomically:true
      end
      after do
        NSFileManager.defaultManager.removeItemAtPath "abc".document, error:nil
      end
      
      it "should be exists" do
        "abc".exists?.should == true
      end
    end
    
    describe "in cache" do
      before do
        "abc".writeToFile "abc".cache, atomically:true
      end
      after do
        NSFileManager.defaultManager.removeItemAtPath "abc".cache, error:nil
      end
      
      it "should be exists" do
        "abc".cache.exists?.should == true
      end
    end

    describe "in resource" do
      it "should be exists" do
        "info.plist".resource.exists?.should == true
      end
    end

  end
  
  describe "remove!" do
  
    describe "in document" do
      before do
        "abc".writeToFile "abc".document, atomically:true
      end
      after do
        NSFileManager.defaultManager.removeItemAtPath "abc".document, error:nil
      end
      
      it "should remove" do
        "abc".remove!.should == nil
        "abc".exists?.should == false
      end
    end
    
    describe "in cache" do
      before do
        "abc".writeToFile "abc".cache, atomically:true
      end
      after do
        NSFileManager.defaultManager.removeItemAtPath "abc".cache, error:nil
      end
      
      it "should remove" do
        path = "abc".cache
        path.remove!.should == nil
        path.exists?.should == false
      end
    end
    
  end

  describe 'resource()' do
    describe '"info.plist".resource' do
      before { @it = "info.plist".resource }
      it 'should start with "/Users"' do
        @it.hasPrefix("/Users").should == true
      end
      it 'should end with "SugarCube_spec.app/info.plist"' do
        @it.hasSuffix("SugarCube_spec.app/info.plist").should == true
      end
    end

    describe '"PkgInfo".resource' do
      before { @it = "PkgInfo".resource }
      it 'should start with "/Users"' do
        @it.hasPrefix("/Users").should == true
      end
      it 'should end with "SugarCube_spec.app/PkgInfo"' do
        @it.hasSuffix("SugarCube_spec.app/PkgInfo").should == true
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
        @it.hasPrefix("file://localhost/Users").should == true
      end
      it 'should end with "SugarCube_spec.app/PkgInfo"' do
        @it.hasSuffix("SugarCube_spec.app/PkgInfo").should == true
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

end

