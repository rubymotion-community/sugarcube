describe "NSURL" do

  it "should have a method #open" do
    'test'.nsurl.respond_to?(:open).should == true
  end

  it "should have a method #nsurl" do
    url = 'https://github.com'.nsurl
    url.nsurl.should == url
  end

  it "should have a method #can_open?" do
    'https://github.com'.nsurl.can_open?.should == true
  end

  it "should have a method #nsdata" do
    'https://github.com'.nsurl.nsdata.should.be.kind_of(NSData)
  end

  it "should have a method #nsurlrequest" do
    'https://github.com'.nsurl.nsurlrequest.should.be.kind_of(NSURLRequest)
  end

  it "should have a method #nsmutableurlrequest" do
    'https://github.com'.nsurl.nsmutableurlrequest.should.be.kind_of(NSMutableURLRequest)
  end

end
