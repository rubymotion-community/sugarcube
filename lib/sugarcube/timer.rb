class Numeric
  def milliseconds
    self / 1000.0
  end
  alias millisecond milliseconds
  alias millisecs milliseconds
  alias millisec milliseconds

  def in_milliseconds
    self * 1000
  end

  def seconds
    self
  end
  alias second seconds
  alias sec seconds
  alias secs seconds

  def in_seconds
    self
  end

  def minutes
    self * 60
  end
  alias minute minutes
  alias min minutes
  alias mins minutes

  def in_minutes
    self / 1.minute.to_f
  end

  def hours
    self * 3600
  end
  alias hour hours

  def in_hours
    self / 1.hour.to_f
  end

  def days
    self.hours * 24
  end
  alias day days

  def in_days
    self / 1.day.to_f
  end

  def weeks
    self.days * 7
  end
  alias week weeks

  def in_weeks
    self / 1.week.to_f
  end

  def months
    self.days * 30
  end
  alias month months

  def in_months
    self / 1.month.to_f
  end

  def years
    self.days * 365
  end
  alias year years

  def in_years
    self / 1.year.to_f
  end

  def later(user_info=nil, &fire)
    NSTimer.scheduledTimerWithTimeInterval(self, target: fire, selector: 'call:', userInfo: user_info, repeats: false)
  end

  def every(user_info=nil, &fire)
    NSTimer.scheduledTimerWithTimeInterval(self, target: fire, selector: 'call:', userInfo: user_info, repeats: true)
  end
end


module SugarCube
  module Timer
    module_function

    def every(time, user_info=nil, &fire)
      time.every user_info, &fire
    end

    def after(time, user_info=nil, &fire)
      time.later user_info, &fire
    end
  end
end
