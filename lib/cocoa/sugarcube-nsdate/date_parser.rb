module SugarCube
  module DateParser
    module_function

    # Parse a date string: E.g.:
    #
    # SugarCube::DateParser.parse_date "There is a date in here tomorrow at 9:00 AM"
    #
    # => 2013-02-20 09:00:00 -0800
    def parse_date(date_string)
      if result = iso8601(date_string)
        return result
      elsif result = sugarcube_detect(date_string).first
        return result.date
      end
    end

    # Parse time zone from date
    #
    # SugarCube::DateParser.parse_date "There is a date in here tomorrow at 9:00 AM EDT"
    #
    # Caveat: This is implemented per Apple documentation. I've never really
    #         seen it work.
    def parse_time_zone(date_string)
      result = sugarcube_detect(date_string).first
      result && result.timeZone
    end

    # Parse a date string: E.g.:
    #
    # SugarCube::DateParser.parse_date "You have a meeting from 9:00 AM to 3:00 PM"
    #
    # => 21600.0
    #
    # Divide by 3600.0 to get number of hours duration.
    def parse_duration(date_string)
      result = sugarcube_detect(date_string).first
      result && result.send(:duration)
    end

    # Parse a date into a raw match array for further processing
    def match(date_string)
      sugarcube_detect(date_string)
    end

    def iso8601(date_string)
      @@sugarcube_iso_detectors ||= [
        "yyyy-MM-dd'T'HH:mm:ss",
        "yyyy-MM-dd'T'HH:mm:ssZ",
        "yyyy-MM-dd'T'HH:mm:ss.S",
        "yyyy-MM-dd'T'HH:mm:ss.SZ",
        ].map do |date_format|
          formatter = NSDateFormatter.alloc.init
          formatter.timeZone = NSTimeZone.timeZoneWithAbbreviation "UTC"
          formatter.dateFormat = date_format
          formatter
        end
      return @@sugarcube_iso_detectors.inject(nil) { |date, formatter| date || formatter.dateFromString(date_string) }
    end

    def sugarcube_detect(date_string)
      @@sugarcube_detector ||= NSDataDetector.dataDetectorWithTypes(NSTextCheckingTypeDate, error:Pointer.new(:object))
      return @@sugarcube_detector.matchesInString(date_string, options:0, range:NSMakeRange(0, date_string.length))
    end
    private :sugarcube_detect

  end
end

class String
  # Use NSDataDetector to parse a string containing a date
  # or duration. These can be of the form:
  #
  # "tomorrow at 7:30 PM"
  # "11.23.2013"
  # "from 7:30 to 10:00 AM"
  #
  # etc.
  def to_date
    SugarCube::DateParser.parse_date(self)
  end

  def to_timezone
    SugarCube::DateParser.parse_time_zone(self)
  end

  def to_duration
    SugarCube::DateParser.parse_duration(self)
  end
end
