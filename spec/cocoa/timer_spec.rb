describe "Numeric Timer methods" do

  describe "Numeric" do
    it "should have a #later method" do
      @later = nil
      0.9.seconds.later do
        @later = true
      end
      wait 1 {
        @later.should == true
      }
    end

    it "should have a #every method" do
      @every = 0
      @stop_me = 480.milliseconds.every do
        @every += 1
      end
      wait 1 {
        @every.should == 2
        @stop_me.invalidate
      }
    end
  end

  describe "NSTimer" do

    it "should have a #later method" do
      @later = nil
      NSTimer.after(0.9.seconds) do
        @later = true
      end
      wait 1 {
        @later.should == true
      }
    end

    it "should have a #every method" do
      @every = 0
      @stop_me = NSTimer.every(480.milliseconds) do
        @every += 1
      end
      wait 1 {
        @every.should == 2
        @stop_me.invalidate
      }
    end

  end

end
