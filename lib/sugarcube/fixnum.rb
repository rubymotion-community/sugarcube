class Fixnum

  #     0xffffff.uicolor
  #     0xffffff.uicolor(0.33)
  # =>
  #     UIColor.colorWithRed(1.0, green:1.0, blue: 1.0, alpha:1.0)
  #     UIColor.colorWithRed(1.0, green:1.0, blue: 1.0, alpha:0.33)
  def uicolor(alpha=nil)
    alpha = 1.0 if alpha.nil?

    red = ((self & 0xFF0000) >> 16).to_f / 255.0
    green = ((self & 0xFF00) >> 8).to_f / 255.0
    blue = (self & 0xFF).to_f / 255.0

    UIColor.colorWithRed(red, green:green, blue:blue, alpha:alpha.to_f)
  end

  def nth
    # if the first two digits of rank are between 11 and 20, it's an
    # 'up-teenth' kinda number
    if self % 100 < 10 || self % 100 > 20
      case self % 10
      when 1
        return "st"
      when 2
        return "nd"
      when 3
        return "rd"
      end
    end

    return "th"
  end

  def before(date)
    date - self
  end

  def ago
    self.before(NSDate.new)
  end

  def after(date)
    date + self
  end

  def hence
    self.after(NSDate.new)
  end

end
