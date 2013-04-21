describe 'Base64' do

  describe 'NSData' do
    it 'should encode data' do
      str = 'testing'
      str_data = str.nsdata
      str_data.to_base64.should == 'dGVzdGluZw=='
    end

    it 'should decode data' do
      str_data = NSData.from_base64('dGVzdGluZw==')
      str = NSString.alloc.initWithData(str_data, encoding:NSUTF8StringEncoding)
      str.should == 'testing'
    end
  end

  describe 'NSString' do
    it 'should encode data' do
      'testing'.to_base64.should == 'dGVzdGluZw=='
    end
    it 'should encode data with encoding' do
      'testing'.to_base64(NSUnicodeStringEncoding).should == '//50AGUAcwB0AGkAbgBnAA=='
    end

    it 'should decode data' do
      NSString.from_base64('dGVzdGluZw==').should == 'testing'
    end
    it 'should decode data with encoding' do
      NSString.from_base64('//50AGUAcwB0AGkAbgBnAA==', NSUnicodeStringEncoding).should == 'testing'
    end
  end

end
