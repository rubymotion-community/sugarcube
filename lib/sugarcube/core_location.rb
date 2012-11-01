# denver = CLLocationCoordinate2D.new(39.764032,-104.963112)
# cincinnati = CLLocationCoordinate2D.new(39.267024,-84.251736)
# denver.distance_to(cincinnati).miles
# denver.delta_miles()
class CLLocationCoordinate2D

  def delta_miles(dx, dy)
    earth_radius = 3960.0

    radius_at_latitude = earth_radius * Math.cos(self.latitude * Math::PI / 180.0)
    if radius_at_latitude > 0
      delta_lng = dx / radius_at_latitude
      delta_lng *= 180.0 / Math::PI
    else
      delta_lng = 0
    end

    delta_lat = dy / earth_radius
    delta_lat *= 180.0 / Math::PI
    CLLocationCoordinate2D.new(self.latitude + delta_lat, self.longitude + delta_lng)
  end

  def distance_to(cl_location_2d)
    my_location = CLLocation.alloc.initWithLatitude(self.latitude, longitude:self.longitude)
    other_location = CLLocation.alloc.initWithLatitude(cl_location_2d.latitude, longitude:cl_location_2d.longitude)
    my_location.distanceFromLocation(other_location)
  end

end
