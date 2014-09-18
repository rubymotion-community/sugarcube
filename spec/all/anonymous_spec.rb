describe "SugarCube::Anonymous" do

  before do
    @h = SugarCube::Anonymous[{ foo: 'FOO', "bar" => 'BAR', falsey: nil, 'truthy' => 'yes!' }]
  end

  describe "Dictionary#to_object" do

    it 'should return an instance of SugarCube::Anonymous' do
      { foo: 'FOO', "bar" => 'BAR' }.to_object.should.be.kind_of(SugarCube::Anonymous)
    end

  end

  describe "constructor" do

    it 'should give an instance of SugarCube::Anonymous' do
      @h.should.be.kind_of(SugarCube::Anonymous)
    end

  end

  describe "getter" do

    it 'should have an #foo method, and return "FOO"' do
      @h.foo.should == 'FOO'
    end

    it 'should have an #bar method, and return "BAR"' do
      @h.bar.should == 'BAR'
    end

    it 'should have an #truthy? method, and return true' do
      @h.truthy?.should == true
    end

    it 'should have an #falsey? method, and return false' do
      @h.falsey?.should == false
    end

    it 'should raise NoMethodError on non-existing keys' do
      should.raise(NoMethodError) { @h.hoge }
    end

  end

  describe "respond_to?" do

    it 'should respond with true if key exists' do
      @h.respond_to?(:foo).should == true
    end

    it 'should respond with false if key does not exist' do
      @h.respond_to?(:not_foo).should == false
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

    it 'should have a #truthy= method, and return "True" and true' do
      @h.truthy = 'True'
      @h.truthy.should == 'True'
      @h.truthy?.should == true
    end

    it 'should have a #falsey= method, and return nil and false' do
      @h.falsey = nil
      @h.falsey.should == nil
      @h.falsey?.should == false
    end

    it 'should raise NoMethodError on non-existing keys' do
      should.raise(NoMethodError) { @h.hoge.should == 'Hoge' }
    end

  end

end


describe "SugarCube::Anonymous nested case" do

  before do
    @h = SugarCube::Anonymous[
      {
        dictionary: { foo: 'FOO', array: [ { is_fine: 'is_fine' } ] },
        array: [ { bar: 'BAR' }, [ 1, 2, 3 ] ]
      }
    ]
  end

  describe "dictionary" do

    it 'should return an instance of SugarCube::Anonymous' do
      @h.dictionary.class.should == SugarCube::Anonymous
    end

    it 'should return a hash which contains a string and an array' do
      @h.dictionary.should == { foo: 'FOO', array: [ { is_fine: 'is_fine' } ] }
    end

    it 'should not copy again' do
      @h.dictionary.object_id.should == @h.dictionary.object_id
    end

    it 'should return is_fine' do
      @h.dictionary.array[0].is_fine.should == 'is_fine'
    end

    describe "Enumerable" do

      describe "each" do

        it 'should return an instance of [SugarCube::Anonymous, SugarCube::AnonymousArray]' do
          a = []
          @h.each{|k,v| a << v.class}
          a[0].should == SugarCube::Anonymous
          a[1].should == SugarCube::AnonymousArray
        end

      end

      describe "map" do

        it 'should return an instance of [SugarCube::Anonymous, SugarCube::AnonymousArray]' do
          a = @h.map{|k,v| v.class}
          a[0].should == SugarCube::Anonymous
          a[1].should == SugarCube::AnonymousArray
        end

      end

      describe "collect" do

        it 'should return an instance of [SugarCube::Anonymous, SugarCube::AnonymousArray]' do
          a = @h.collect{|k,v| v.class}
          a[0].should == SugarCube::Anonymous
          a[1].should == SugarCube::AnonymousArray
        end

      end

    end

  end

  describe "array" do

    it 'should return an instance of SugarCube::AnonymousArray' do
      @h.array.class.should == SugarCube::AnonymousArray
    end

    it 'should not copy again' do
      @h.array.object_id.should == @h.array.object_id
    end

    describe "inner object" do

      it 'should return an instance of SugarCube::Anonymous' do
        @h.array[0].class.should == SugarCube::Anonymous
      end

      it 'should return an instance of SugarCube::Anonymous' do
        @h.array.first.class.should == SugarCube::Anonymous
      end

      it 'should return an instance of SugarCube::AnonymousArray' do
        @h.array[1].class.should == SugarCube::AnonymousArray
      end

      it 'should return an instance of SugarCube::AnonymousArray' do
        @h.array.last.class.should == SugarCube::AnonymousArray
      end

    end

    describe "Enumerable" do

      describe "each" do

        it 'should return an instance of [SugarCube::Anonymous, SugarCube::AnonymousArray]' do
          a = []
          @h.array.each{|e| a << e.class}
          a[0].should == SugarCube::Anonymous
          a[1].should == SugarCube::AnonymousArray
        end

      end

      describe "each_with_index" do

        it 'should return an instance of [0,1]' do
          a = []
          @h.array.each_with_index{|e,i| a << i}
          a.should == [0,1]
        end

      end

      describe "map" do

        it 'should return an instance of [SugarCube::Anonymous, SugarCube::AnonymousArray]' do
          a = @h.array.map{|e| e.class}
          a[0].should == SugarCube::Anonymous
          a[1].should == SugarCube::AnonymousArray
        end

      end

      describe "collect" do

        it 'should return an instance of [SugarCube::Anonymous, SugarCube::AnonymousArray]' do
          a = @h.array.collect{|e| e.class}
          a[0].should == SugarCube::Anonymous
          a[1].should == SugarCube::AnonymousArray
        end

      end

      describe "find" do

        it 'should return then first object' do
          r = @h.array.find{|e| e.is_a? Hash}
          r.should == @h.array[0]
        end

        it 'should return the second object' do
          r = @h.array.find{|e| e.is_a? Array}
          r.should == @h.array[1]
        end

      end

    end

  end

end
