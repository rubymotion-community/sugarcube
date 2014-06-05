class Fixnum

  def nstimezone
    NSTimeZone.timeZoneForSecondsFromGMT(self)
  end

end
