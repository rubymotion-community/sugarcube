class NSDate
  def year
    return components(NSYearCalendarUnit).year
  end

  def month
    return components(NSMonthCalendarUnit).month
  end

  def day
    return components(NSDayCalendarUnit).day
  end

  def ymd
    return [self.year, self.month, self.day]
  end

  def weekday
    return components(NSWeekdayCalendarUnit).weekday
  end

  def hour
    return components(NSHourCalendarUnit).hour
  end

  def minute
    return components(NSMinuteCalendarUnit).minute
  end

  def second
    return components(NSSecondCalendarUnit).second
  end

  def timezone
    return components(NSTimeZoneCalendarUnit).timeZone
  end
  alias timeZone timezone

  def utc_offset
    return self.timezone.secondsFromGMT
  end

  def hms
    return [self.hour, self.minute, self.second]
  end

  def datetime
    return [self.year, self.month, self.day, self.hour, self.minute, self.second]
  end

  def +(time_interval)
    return self.dateByAddingTimeInterval(time_interval)
  end

  private
  def components(components)
    unless (@@calendar ||= nil)
      @@calendar = NSCalendar.alloc.initWithCalendarIdentifier(NSGregorianCalendar)
    end
    return @@calendar.components(components, fromDate:self)
  end
end
