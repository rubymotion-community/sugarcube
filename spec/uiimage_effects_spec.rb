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

end
