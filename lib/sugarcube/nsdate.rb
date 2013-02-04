class NSDate

  def self.from_components(components)
    date_components = NSDateComponents.new
    components.each do |property,value|
      date_components.send("#{property}=", value)
    end
    calendar = NSCalendar.alloc.initWithCalendarIdentifier(NSGregorianCalendar)
    return calendar.dateFromComponents(date_components)
  end

  def string_with_style(style)
    date_formatter = NSDateFormatter.new
    if style.is_a? Symbol
      style = style.nsdatestyle
    end
    date_formatter.setDateStyle(style)
    date_formatter.stringFromDate(self)
  end

  def string_with_format(format)
    format_template = NSDateFormatter.dateFormatFromTemplate(format, options:0,
                                                      locale:NSLocale.currentLocale)
    date_formatter = NSDateFormatter.new
    date_formatter.setDateFormat(format_template)
    date_formatter.stringFromDate(self)
  end

  def upto(last_date, delta={days: 1}, &block)
    return if last_date < self

    date = self
    while date <= last_date
      if block.arity == 0
        block.call
      else
        block.call(date)
      end
      new_date = date.delta(delta)
      break if new_date <= date
      date = new_date
    end
  end

  def downto(last_date, delta={days: -1}, &block)
    return if last_date > self

    date = self
    while date >= last_date
      if block.arity == 0
        block.call
      else
        block.call(date)
      end
      new_date = date.delta(delta)
      break if new_date >= date
      date = new_date
    end
  end

  def timezone
    return _calendar_components(NSTimeZoneCalendarUnit).timeZone
  end
  alias timeZone timezone

  def era
    return _calendar_components(NSEraCalendarUnit).era
  end

  def today?
    today = self.class.new
    return same_day?(today)
  end

  def same_day?(other)
    return other.day == self.day &&
           other.month == self.month &&
           other.year == self.year &&
           other.era == self.era
  end

  # In the rare case you actually get an NSDate object - not a Time object - this
  # method is actually useful.
  def utc_offset
    return self.timezone.secondsFromGMT
  end

  def leap_year?
    self.year % 4 == 0 and self.year % 100 != 0 or self.year % 400 == 0
  end

  #  (main)> t = Time.new
  #  => 2012-09-27 11:29:12 +0900
  #  (main)> t.time_array
  #  => [2012, 9, 27]
  def date_array
    return [self.year, self.month, self.day]
  end

  #  (main)> t = Time.new
  #  => 2012-09-27 11:29:12 +0900
  #  (main)> t.time_array
  #  => [11, 29, 12]
  def time_array
    return [self.hour, self.min, self.sec]
  end

  #  (main)> t = Time.new
  #  => 2012-09-27 11:29:12 +0900
  #  (main)> t.time_array
  #  => [2012, 9, 12, 11, 29, 12]
  def datetime_array
    return [self.year, self.month, self.day, self.hour, self.min, self.sec]
  end

  #  (main)> t = Time.new
  #  => 2012-09-27 11:29:12 +0900
  #  (main)> t.start_of_day
  #  => 2012-09-27 00:00:00 +0900
  def start_of_day
    time_interval = self.hour.hours + self.min.minutes + self.sec
    return self - time_interval
  end

  #  (main)> t = Time.new
  #  => 2012-09-27 11:29:12 +0900
  #  (main)> t.end_of_day
  #  => 2012-09-28 00:00:00 +0900
  def end_of_day
    time_interval = (23 - self.hour).hours + (59 - self.min).minutes - self.sec + 60
    return self + time_interval
  end

  #  (main)> t = Time.new
  #  => 2012-09-27 11:29:12 +0900
  #  (main)> t.start_of_month
  #  => 2012-09-01 00:00:00 +0900
  def start_of_month
    return self.start_of_day.delta(days:1 - day)
  end

  #  (main)> t = Time.new
  #  => 2012-09-27 11:29:12 +0900
  #  (main)> t.end_of_month
  #  => 2012-10-01 00:00:00 +0900
  def end_of_month
    return self.end_of_day.delta(days:days_in_month - day)
  end

  def days_in_month
    NSCalendar.currentCalendar.rangeOfUnit(NSDayCalendarUnit, inUnit:NSMonthCalendarUnit, forDate:self).length
  end

  def days_in_year
    leap_year? ? 366 : 365
  end

  private
  def _calendar_components(components)
    return NSCalendar.currentCalendar.components(components, fromDate:self)
  end
end
