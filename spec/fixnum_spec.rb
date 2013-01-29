describe "Fixnum" do

  it "should have a 0xffffff#uicolor method" do
    color = 0xffffff.uicolor
    color.red.should == 1
    color.green.should == 1
    color.blue.should == 1
    color.alpha.should == 1
  end

  it "should have a 0x000000#uicolor(0.5) method" do
    color = 0.uicolor(0.5)
    color.red.should == 0
    color.green.should == 0
    color.blue.should == 0
    color.alpha.should == 0.5
  end

  it "should have a #nth method" do
    {
      0    => 'th',
      1    => 'st',
      2    => 'nd',
      3    => 'rd',
      4    => 'th',
      5    => 'th',
      6    => 'th',
      7    => 'th',
      8    => 'th',
      9    => 'th',
      10   => 'th',
      11   => 'th',
      12   => 'th',
      13   => 'th',
      14   => 'th',
      15   => 'th',
      16   => 'th',
      17   => 'th',
      18   => 'th',
      19   => 'th',
      20   => 'th',
      21   => 'st',
      22   => 'nd',
      23   => 'rd',
      24   => 'th',
      25   => 'th',
      26   => 'th',
      27   => 'th',
      28   => 'th',
      29   => 'th',
      30   => 'th',
      31   => 'st',
      32   => 'nd',
      33   => 'rd',
      34   => 'th',
      35   => 'th',
      36   => 'th',
      37   => 'th',
      38   => 'th',
      39   => 'th',
      100  => 'th',
      101  => 'st',
      102  => 'nd',
      103  => 'rd',
      104  => 'th',
      105  => 'th',
      106  => 'th',
      107  => 'th',
      108  => 'th',
      109  => 'th',
      110  => 'th',
      111  => 'th',
      112  => 'th',
      113  => 'th',
      114  => 'th',
      115  => 'th',
      116  => 'th',
      117  => 'th',
      118  => 'th',
      119  => 'th',
      2020 => 'th',
      2000 => 'th',
      2001 => 'st',
      2002 => 'nd',
      2003 => 'rd',
    }.each do |num, expected|
      num.nth.should == "#{expected}"
    end
  end

  it "should have a #before method" do
    relative_to = NSDate.new
    1.day.before(relative_to).should == relative_to - 1.day
    2.years.before(relative_to).should == relative_to - 2.years
  end

  it "should have an #after method" do
    relative_to = NSDate.new
    1.day.after(relative_to).should == relative_to + 1.day
    2.years.after(relative_to).should == relative_to + 2.years
  end

  it "should have a #ago method" do
    now_a = NSDate.new - 2
    now_b = NSDate.new + 2
    1.day.ago.should > now_a - 1.day
    1.day.ago.should < now_b - 1.day
    2.years.ago.should > now_a - 2.years
    2.years.ago.should < now_b - 2.years
  end

  it "should have an #hence method" do
    now_a = NSDate.new - 2
    now_b = NSDate.new + 2
    1.day.hence.should > now_a + 1.day
    1.day.hence.should < now_b + 1.day
    2.years.hence.should > now_a + 2.years
    2.years.hence.should < now_b + 2.years
  end

end
