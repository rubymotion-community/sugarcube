class NSDate
  # these formatters are used in `string_with_format`.  Symbols are converted to
  # a string using string_with_format's templating, and strings are concatenated
  # as-is
  SugarCubeFormats = {
    iso8601: [:yyyy, '-', :MM, '-', :dd, ' ', :'HH:mm:ss.SSS'],
    ymd: [:yyyy, '-', :MM, '-', :dd],
    hms: [:'HH:mm:ss.SSS'],
  }

  def self.from_components(components)
    date_components = NSDateComponents.new
    components.each do |property,value|
      date_components.send("#{property}=", value)
    end
    calendar = NSCalendar.alloc.initWithCalendarIdentifier(NSGregorianCalendar)
    return calendar.dateFromComponents(date_components)
  end

  def self.today
    NSDate.new.start_of_day
  end

  def self.tomorrow
    NSDate.new.delta(days: 1).start_of_day
  end

  def self.yesterday
    NSDate.new.delta(days: -1).start_of_day
  end

  def string_with_style(date_style=NSDateFormatterMediumStyle,time_style=NSDateFormatterNoStyle)
    date_formatter = NSDateFormatter.new
    date_style = date_style.nsdatestyle if date_style.is_a? Symbol
    time_style = time_style.nsdatestyle if time_style.is_a? Symbol
    date_formatter.setDateStyle(date_style)
    date_formatter.setTimeStyle(time_style)
    date_formatter.stringFromDate(self)
  end

  # Pass in a format string or a Symbol.  The Symbol must exist in
  # NSDate::SugarCubeFormats.
  #
  # See
  # <https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html#//apple_ref/doc/uid/TP40002369-SW1>
  # and
  # <http://www.unicode.org/reports/tr35/tr35-19.html#Date_Format_Patterns>
  # for more information about date format strings.
  def string_with_format(format)
    if format.is_a?(Symbol)
      formatters = SugarCubeFormats[format]
      raise "No format found for #{format.inspect}" unless formatters
      retval = ''
      formatters.each do |formatter|
        case formatter
        when Symbol
          retval << string_with_format(formatter.to_s)
        when String
          retval << formatter
        end
      end
      return retval
    else
      format_template = NSDateFormatter.dateFormatFromTemplate(format, options:0,
                                                        locale:NSLocale.currentLocale)
      date_formatter = NSDateFormatter.new
      date_formatter.setDateFormat(format_template)
      return date_formatter.stringFromDate(self)
    end
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
  #  (main)> t.start_of_week
  #  => 2012-09-23 00:00:00 +0900
  def start_of_week(start_day=nil)
    result = self - days_to_week_start(start_day).days
    result.start_of_day
  end

  #  (main)> t = Time.new
  #  => 2012-09-27 11:29:12 +0900
  #  (main)> t.start_of_week
  #  => 2012-09-30 00:00:00 +0900
  def end_of_week(start_day=nil)
    result = self - days_to_week_start(start_day).days + 6.days
    result.end_of_day
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

  def days_to_week_start(start_day=nil)
    start_day_number = week_day_index(start_day) || local_week_start
    current_day_number = _calendar_components(NSWeekdayCalendarUnit).weekday
    (current_day_number - start_day_number) % 7
  end

  def local_week_start
    NSCalendar.currentCalendar.firstWeekday
  end

  def week_day_index(week_day=:monday)
    day = week_day.to_s.capitalizedString
    index = NSDateFormatter.new.weekdaySymbols.index(day)
    return nil unless index
    index + 1
  end

end
