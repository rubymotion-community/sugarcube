class NSDate
  def timezone
    return _calendar_components(NSTimeZoneCalendarUnit).timeZone
  end
  alias timeZone timezone

  def utc_offset
    return self.timezone.secondsFromGMT
  end

  def leap?
    self.year % 4 == 0 and self.year % 100 != 0 or self.year % 400 == 0
  end

  def date
    return [self.year, self.month, self.day]
  end

  def time
    return [self.hour, self.min, self.sec]
  end

  def datetime
    return [self.year, self.month, self.day, self.hour, self.min, self.sec]
  end

  def start_of_day
    time_interval = self.hour.hours + self.min.minutes + self.sec
    return self - time_interval
  end

  def end_of_day
    time_interval = (23 - self.hour).hours + (59 - self.min).minutes + 60 - self.sec
    return self + time_interval
  end

  def days_in_month
    NSCalendar.currentCalendar.rangeOfUnit(NSDayCalendarUnit, inUnit:NSMonthCalendarUnit, forDate:self).length
  end

  def days_in_year
    NSCalendar.currentCalendar.rangeOfUnit(NSDayCalendarUnit, inUnit:NSYearCalendarUnit, forDate:self).length
  end

  private
  def _calendar_components(components)
    return NSCalendar.currentCalendar.components(components, fromDate:self)
  end
end
