describe "NSDictionary" do

  before do
    @h = { foo: 'FOO', "bar" => 'BAR' }
  end

  describe "getter" do
  
    it 'should have an #foo method. and get "FOO"' do
      @h.foo.should == 'FOO'
    end

    it 'should have an #bar method. and get "BAR"' do
      @h.bar.should == 'BAR'
    end

    it 'should raise NoMethodError' do
      begin
        @h.hoge
        flunk
      rescue => e
        e.class.should == NoMethodError
      end
    end
    
  end
  
  describe "setter" do
  
    it 'should have an #foo= method. and get "Foo"' do
      @h.foo = "Foo"
      @h.foo.should == 'Foo'
    end

    it 'should manage an #bar= method. and get "Bar"' do
      @h.bar = 'Bar'
      @h.bar.should == 'Bar'
    end

    it 'should raise NoMethodError' do
      begin
        @h.hoge = 'Hoge'
        flunk
      rescue => e
        e.class.should == NoMethodError
      end
    end
    
  end
  

end
