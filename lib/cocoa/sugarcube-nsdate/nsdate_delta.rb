class NSDate

  def delta(_components)
    components = {}.update(_components)
    is_very_specific = components.has_key?(:seconds)
    is_very_specific ||= components.has_key?(:minutes)
    is_very_specific ||= components.has_key?(:hours)

    y = components.delete(:years) || 0
    mo = components.delete(:months) || 0
    d = components.delete(:days) || 0
    h = components.delete(:hours) || 0
    mi = components.delete(:minutes) || 0
    s = components.delete(:seconds) || 0
    w = components.delete(:weeks) || 0
    raise "Unknown arguments #{components.keys}" unless components.empty?

    is_dst = self.dst?

    delta = s
    # todo: leap second adjustment?  can leap seconds be detected?
    delta += mi * 60
    delta += h * 3600

    return_date = self + delta

    # using days_in_month, this is pretty easy.  12 mos per year IS a constant,
    # and then we just keep adding the number of days in the month (or last month
    # if we're going backwards).  The curve ball is that when we are in day
    # 29,30,31, we might jump forward a month and "fall off" to the next month.
    # In this case, we add a correction.  We will always move forwards or
    # backwards until the return_date.day is correct.
    mo += y * 12
    if mo != 0
      if return_date.day > 28
        # we will try and preserve this day
        correct_day_of_month = return_date.day
      else
        correct_day_of_month = nil
      end

      if mo > 0
        mo.times do
          delta = return_date.days_in_month
          return_date += delta * 3600 * 24

          # if the day_of_month is wrong, it must be because we either added PAST
          # the correct month (so roll back), or because we WERE rolled back and
          # when we moved forward a month, we were left back at the smaller day.
          if correct_day_of_month
            if return_date.day < 28
              return_date -= return_date.day * 3600 * 24
            elsif return_date.day < correct_day_of_month
              fix = correct_day_of_month > return_date.days_in_month ? return_date.days_in_month : correct_day_of_month
              return_date += (fix - return_date.day) * 3600 * 24
            end
          end
        end
      else  # mo < 0
        (-mo).times do
          # subtract *last* months number of days.
          # there is a REALLY rare case where subtracting return_date.day is one
          # hour short of "last month" and so you end up with THIS month.  there
          # is NEVER a case when subtracting return_date.day+1 days is NOT
          # "previous month".  dates. :-|  f-em.
          delta = (return_date - (return_date.day+1) * 3600 * 24).days_in_month
          return_date -= delta * 3600 * 24
          # same correction as above
          if correct_day_of_month
            if return_date.day < 28
              return_date -= return_date.day * 3600 * 24
            elsif return_date.day < correct_day_of_month
              fix = correct_day_of_month > return_date.days_in_month ? return_date.days_in_month : correct_day_of_month
              return_date += (fix - return_date.day) * 3600 * 24
            end
          end
        end
      end
    end

    delta = 0
    delta += d * 3600 * 24
    delta += w * 3600 * 24 * 7
    return_date += delta

    # DST adjustment, unless minutes, hours, or seconds were specified.
    #
    # the thinking here is that if they WERE specified, the delta should be
    # accurate to that granularity.  if they were omitted, the hour component
    # should not change, even though an off-by-one adjustment is needed
    #
    # for instance.  3/10/2012 is not in DST.  3/11/2012 IS.
    # Time.at(3/10/2012)  # => 2012-03-10 17:00:00 -0700
    # Time.at(3/10/2012).delta(days:1)  # => 2012-03-11 17:00:00 -0600
    #
    # notice the time is the SAME, even though the time zone is different.  BUT:
    # Time.at(3/10/2012).delta(hours:24)  # => 2012-03-11 17:00:00 -0600
    # Time.at(3/10/2012).delta(hours:25)  # => 2012-03-11 18:00:00 -0600
    unless return_date.dst? == is_dst or is_very_specific
      if is_dst
        return_date += 3600
      else
        return_date -= 3600
      end
    end

    return return_date
  end

end
