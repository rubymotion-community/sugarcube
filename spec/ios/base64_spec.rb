describe 'Base64' do

  describe 'UIImage' do

    it 'should convert image data (PNG) to base64' do
      'test'.uiimage.nsdata.to_base64.should == 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAHgCAIAAADrGJBNAAAAAXNSR0IArs4c6QAAABxpRE9UAAAAAgAAAAAAAADwAAAAKAAAAPAAAADwAAAAS9r5uVEAAAAXSURBVEgNYrhrxMAwikfDYDQNDMk0AAAAAP//6TQa9AAAABVJREFUY7hrxMAwikfDYDQNDMk0AACNnfwwqs717AAAAABJRU5ErkJggg=='
    end

  end

end
