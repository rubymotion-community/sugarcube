describe "NSDate upto/downto" do

  before do
    @start = NSDate.from_components(year:2013, month: 1, day: 1)
  end

  it "should have an #upto method that doesn't do anything if receiver < arg" do
    bam = 0
    @start.upto(@start.delta(days:-1)) do
      bam += 1
    end
    bam.should == 0
  end

  it "should have a #upto method that should allow the same date" do
    bam = 0
    @start.upto(@start) do
      bam += 1
    end
    bam.should == 1
  end

  it "should have an #upto method that should count up by days" do
    bam = 0
    @start.upto(@start.delta(days:10)) do
      bam += 1
    end
    bam.should == 11
  end
  it "should have a #downto method that should count down by days" do
    bam = 0
    @start.downto(@start.delta(days:-10)) do
      bam += 1
    end
    bam.should == 11
  end


  it "should have an #upto method that should pass the date to the block" do
    @start.upto(@start.delta(days:1)) do |date|
      NSDate.should === date
    end
  end

  it "should have an #upto method that should count up by any delta" do
    bam = 0
    @start.upto(@start.delta(days:1), hours:1) do
      bam += 1
    end
    bam.should == 25
  end

  it "should have an #upto method that should abort if delta is negative" do
    bam = 0
    @start.upto(@start.delta(days:1), hours:-1) do
      bam += 1
    end
    bam.should == 1
  end

  it "should have a #downto method that doesn't do anything if receiver > arg" do
    bam = 0
    @start.downto(@start.delta(days:1)) do
      bam += 1
    end
    bam.should == 0
  end

  it "should have a #downto method that should allow the same date" do
    bam = 0
    @start.downto(@start) do
      bam += 1
    end
    bam.should == 1
  end

  it "should have a #downto method that should count down by days" do
    bam = 0
    @start.downto(@start.delta(days:-10)) do
      bam += 1
    end
    bam.should == 11
  end

  it "should have a #downto method that should pass the date to the block" do
    @start.downto(@start.delta(days:-1)) do |date|
      NSDate.should === date
    end
  end

  it "should have a #downto method that should count down by any delta" do
    bam = 0
    @start.downto(@start.delta(days:-1), hours:-1) do
      bam += 1
    end
    bam.should == 25
  end

  it "should have a #downto method that should abort if delta is positive" do
    bam = 0
    @start.downto(@start.delta(days:-1), hours:1) do
      bam += 1
    end
    bam.should == 1
  end

end
