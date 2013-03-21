describe "SugarCube::Anonymous" do

  before do
    @h = SugarCube::Anonymous[{ foo: 'FOO', "bar" => 'BAR' }]
  end

  describe "NSDictionary#to_object" do

    it 'should return an instance of SugarCube::Anonymous' do
      SugarCube::Anonymous.should === { foo: 'FOO', "bar" => 'BAR' }.to_object
    end

  end

  describe "constructor" do

    it 'should give an instance of SugarCube::Anonymous' do
      SugarCube::Anonymous.should === @h
    end

  end

  describe "getter" do

    it 'should have an #foo method, and return "FOO"' do
      @h.foo.should == 'FOO'
    end

    it 'should have an #bar method, and return "BAR"' do
      @h.bar.should == 'BAR'
    end

    it 'should raise NoMethodError on non-existing keys' do
      should.raise(NoMethodError) {
        @h.hoge
      }
    end

  end

  describe "setter" do

    it 'should have an #foo= method, and return "Foo"' do
      @h.foo = 'Foo'
      @h.foo.should == 'Foo'
    end

    it 'should have a #bar= method, and return "Bar"' do
      @h.bar = 'Bar'
      @h.bar.should == 'Bar'
    end

    it 'should raise NoMethodError on non-existing keys' do
      should.raise(NoMethodError) {
        @h.hoge.should == 'Hoge'
      }
    end

  end

end
