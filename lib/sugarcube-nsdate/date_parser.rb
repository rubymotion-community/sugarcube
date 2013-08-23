module SugarCube
  module DateParser
    # Parse a date string: E.g.:
    #
    # SugarCube::DateParser.parse_date "There is a date in here tomorrow at 9:00 AM"
    #
    # => 2013-02-20 09:00:00 -0800
    def self.parse_date(date_string)
      result = sugarcube_detect(date_string).first
      if result
        return result.date
      else
        return sugarcube_iso8601(date_string)
      end
    end

    # Parse time zone from date
    #
    # SugarCube::DateParser.parse_date "There is a date in here tomorrow at 9:00 AM EDT"
    #
    # Caveat: This is implemented per Apple documentation. I've never really
    #         seen it work.
    def self.parse_time_zone(date_string)
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
    def self.parse_duration(date_string)
      result = sugarcube_detect(date_string).first
      result && result.send(:duration)
    end

    # Parse a date into a raw match array for further processing
    def self.match(date_string)
      sugarcube_detect(date_string)
    end

    private
    def self.sugarcube_detect(date_string)
      @@sugarcube_detector ||= NSDataDetector.dataDetectorWithTypes(NSTextCheckingTypeDate, error:Pointer.new(:object))
      return @@sugarcube_detector.matchesInString(date_string, options:0, range:NSMakeRange(0, date_string.length))
    end

    def self.sugarcube_iso8601(date_string)
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
