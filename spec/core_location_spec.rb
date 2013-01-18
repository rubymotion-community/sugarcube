describe "CoreLocation" do
  before do
    @denver = CLLocationCoordinate2D.new(39.764032, -104.963112)
    @cincinnati = CLLocationCoordinate2D.new(39.267024, -84.251736)
  end

  it "should calculate distance in miles" do
    @denver.distance_to(@cincinnati).miles.round.should == 1101
  end

  it "should calculate distance in kilometers" do
    @denver.distance_to(@cincinnati).kilometers.round.should == 1772
  end

end
