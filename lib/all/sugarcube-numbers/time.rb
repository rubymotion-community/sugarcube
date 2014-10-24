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
  alias per_millisecond in_milliseconds

  def seconds
    self
  end
  alias second seconds
  alias sec seconds
  alias secs seconds

  def in_seconds
    self
  end
  alias per_second in_seconds

  def minutes
    self * 60
  end
  alias minute minutes
  alias min minutes
  alias mins minutes

  def in_minutes
    self / 1.minute.to_f
  end
  alias per_minute in_minutes

  def hours
    self * 3600
  end
  alias hour hours

  def in_hours
    self / 1.hour.to_f
  end
  alias per_hour in_hours

  def days
    self.hours * 24
  end
  alias day days

  def in_days
    self / 1.day.to_f
  end
  alias per_day in_days

  def weeks
    self.days * 7
  end
  alias week weeks

  def in_weeks
    self / 1.week.to_f
  end
  alias per_week in_weeks

  # INACCURATE and COULD CHANGE in the future.
  def months
    self.days * 30.416
  end
  alias month months

  def in_months
    self / 1.month.to_f
  end
  alias per_month in_months

  # INACCURATE and COULD CHANGE in the future.
  def years
    self.days * 365.25
  end
  alias year years

  def in_years
    self / 1.year.to_f
  end
  alias per_year in_years

end
