describe "Symbol uicolor" do

  before do
    @colors = Symbol.uicolors
  end
  
  it 'should have 21 colors' do
    @colors.size.should == 21
  end
  
  it 'should have black color' do
    @colors[:black].should == :blackColor
  end

  it 'should have blue color' do
    @colors[:blue].should == :blueColor
  end

  it 'should have brown color' do
    @colors[:brown].should == :brownColor
  end

  it 'should have cyan color' do
    @colors[:cyan].should == :cyanColor
  end

  it 'should have darkgray color' do
    @colors[:darkgray].should == :darkGrayColor
  end

  it 'should have gray color' do
    @colors[:gray].should == :grayColor
  end

  it 'should have green color' do
    @colors[:green].should == :greenColor
  end

  it 'should have lightgray color' do
    @colors[:lightgray].should == :lightGrayColor
  end

  it 'should have magenta color' do
    @colors[:magenta].should == :magentaColor
  end

  it 'should have orange color' do
    @colors[:orange].should == :orangeColor
  end

  it 'should have purple color' do
    @colors[:purple].should == :purpleColor
  end

  it 'should have red color' do
    @colors[:red].should == :redColor
  end

  it 'should have yellow color' do
    @colors[:yellow].should == :yellowColor
  end

  it 'should have white color' do
    @colors[:white].should == :whiteColor
  end

  it 'should have clear color' do
    @colors[:clear].should == :clearColor
  end

  it 'should have light_text color' do
    @colors[:light_text].should == :lightTextColor
  end

  it 'should have dark_text color' do
    @colors[:dark_text].should == :darkTextColor
  end

  it 'should have table_view color' do
    @colors[:table_view].should == :groupTableViewBackgroundColor
  end

  it 'should have scroll_view color' do
    @colors[:scroll_view].should == :scrollViewTexturedBackgroundColor
  end

  it 'should have flipside color' do
    @colors[:flipside].should == :viewFlipsideBackgroundColor
  end

  it 'should have under_page color' do
    @colors[:under_page].should == :underPageBackgroundColor
  end

end
