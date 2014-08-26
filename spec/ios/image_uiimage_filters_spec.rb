describe "UIImage effects w/ CIImage & CIFilter" do
  before do
    @image = 'little_square'.uiimage
  end

  describe 'should apply a gaussian blur' do
    it 'should have a gaussian_blur method' do
      -> {
        @image.gaussian_blur.should.is_a(UIImage)
      }.should.not.raise
    end
    it 'should accept a :radius option' do
      -> {
        @image.gaussian_blur(radius: 5).should.is_a(UIImage)
      }.should.not.raise
    end
    it 'should accept a :radius argument in 0th position' do
      -> {
        @image.gaussian_blur(5).should.is_a(UIImage)
      }.should.not.raise
    end
  end

  describe 'should apply inverted colors' do
    it 'should have inverted method' do
      -> {
        @image.inverted.should.is_a(UIImage)
      }.should.not.raise
    end
  end

  describe 'should apply a darken filter' do
    it 'should have a darken method' do
      -> {
        @image.darken.should.is_a(UIImage)
      }.should.not.raise
    end
    it 'should accept a :saturation option' do
      -> {
        @image.darken(saturation: 5).should.is_a(UIImage)
      }.should.not.raise
    end
    it 'should accept a :brightness option' do
      -> {
        @image.darken(brightness: 5).should.is_a(UIImage)
      }.should.not.raise
    end
    it 'should accept a :saturation and a :brightness option' do
      -> {
        @image.darken(saturation: 5, brightness: 5).should.is_a(UIImage)
      }.should.not.raise
    end
  end

end
