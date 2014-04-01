class Fixnum

  def nth
    # if the first two digits of rank are between 11 and 20, it's an
    # 'up-teenth' kinda number
    modulo_100 = self % 100
    if modulo_100 < 10 || modulo_100 > 20
      case self % 10
      when 1
        return 'st'
      when 2
        return 'nd'
      when 3
        return 'rd'
      end
    end

    return "th"
  end

  def ordinalize
    return "#{self}#{nth}"
  end

end
