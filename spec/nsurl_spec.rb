describe "NSURL" do

  it "should have a method #open" do
    'test'.nsurl.respond_to?(:open).should == true
  end

  it "should have a method #can_open?" do
    'https://github.com'.nsurl.can_open?.should == true
  end

  it "should have a method #nsdata?" do
    NSData.should === 'https://github.com'.nsurl.nsdata
  end

  it "should have a method #nsurlrequest" do
    NSURLRequest.should === 'https://github.com'.nsurl.nsurlrequest
  end

  it "should have a method #nsmutableurlrequest" do
    NSMutableURLRequest.should === 'https://github.com'.nsurl.nsmutableurlrequest
  end

end
