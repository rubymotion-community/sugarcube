class NSColor

  def self.systemControlColor
    NSColor.colorForControlTint(NSColor.currentControlTint)
  end

  def self.blueControlColor
    NSColor.colorForControlTint(NSBlueControlTint)
  end

  def self.graphiteControlColor
    NSColor.colorForControlTint(NSGraphiteControlTint)
  end

  def nscolor(alpha=nil)
    if alpha
      if named_color_space?
        self.colorUsingColorSpace(NSColorSpace.genericRGBColorSpace).colorWithAlphaComponent(alpha.to_f)
      else
        self.colorWithAlphaComponent(alpha.to_f)
      end
    else
      if named_color_space?
        self.colorUsingColorSpace(NSColorSpace.genericRGBColorSpace)
      else
        self
      end
    end
  end

  def named_color_space?
    colorSpaceName == "NSNamedColorSpace"
  end

  def cgcolor(alpha=nil)
    nscolor(alpha).CGColor
  end

  def skcolor(alpha=nil)
    nscolor(alpha)
  end

  # blends two colors by averaging the RGB and alpha components.
  # @example
  #     :white.nscolor + :black.nscolor == :gray.nscolor
  def +(color)
    mix_with(color.nscolor, 0.5)
  end

  # blends two colors by adding the colors, with an upper maximum of 255.
  # Adding white to any color will create white, adding black will do nothing.
  # Also takes transparency into account; adding a transparent color has no
  # effect, adding an opaque color has the most effect.
  # @example
  #     :red.nscolor << :blue.nscolor == '#ff00ff'.nscolor (:magenta)
  #     :red.nscolor << :blue.nscolor(0.5) == '#ff0080'.nscolor (pinkish)
  def <<(color)
    r = [1.0, color.red * color.alpha + self.red].min
    g = [1.0, color.green * color.alpha + self.green].min
    b = [1.0, color.blue * color.alpha + self.blue].min
    a = self.alpha
    if NSColor.respond_to?('colorWithRed:green:blue:alpha:')
      NSColor.colorWithRed(r, green:g, blue:b, alpha:a)
    else
      NSColor.colorWithCalibratedRed(r, green:g, blue:b, alpha:a)
    end
  end

  # a more generic color mixing method.  mixes two colors, but a second
  # parameter determines how much of each.  0.5 means equal parts, 0.0 means use
  # all of the first, and 1.0 means use all of the second
  def mix_with(color, amount)
    color = color.nscolor

    # make amount between 0 and 1
    amount = [[0, amount].max, 1].min
    # start with precise amounts: 0, 0.5, and 1.
    if amount == 0 && self.alpha == color.alpha
      self
    elsif amount == 1 && self.alpha == color.alpha
      color
    elsif amount == 0.5 && self.alpha == color.alpha
      r = (self.red + color.red) / 2
      g = (self.green + color.green) / 2
      b = (self.blue + color.blue) / 2
      a = self.alpha
      if NSColor.respond_to?('colorWithRed:green:blue:alpha:')
        NSColor.colorWithRed(r, green:g, blue:b, alpha:a)
      else
        NSColor.colorWithCalibratedRed(r, green:g, blue:b, alpha:a)
      end
    else
      a = (color.alpha - self.alpha) * amount + self.alpha
      return NSColor.clearColor if a == 0

      color_red = color.red * color.alpha + self.red * (1 - color.alpha)
      self_red = self.red * self.alpha + color.red * (1 - self.alpha)
      color_green = color.green * color.alpha + self.green * (1 - color.alpha)
      self_green = self.green * self.alpha + color.green * (1 - self.alpha)
      color_blue = color.blue * color.alpha + self.blue * (1 - color.alpha)
      self_blue = self.blue * self.alpha + color.blue * (1 - self.alpha)

      r = (color_red - self_red) * amount + self_red
      g = (color_green - self_green) * amount + self_green
      b = (color_blue - self_blue) * amount + self_blue
      if NSColor.respond_to?('colorWithRed:green:blue:alpha:')
        NSColor.colorWithRed(r, green:g, blue:b, alpha:a)
      else
        NSColor.colorWithCalibratedRed(r, green:g, blue:b, alpha:a)
      end
    end
  end

  # inverts the RGB channel.  keeps the alpha channel unchanged
  # @example
  #   :white.nscolor.invert == :black.nscolor
  def invert
    r = 1.0 - self.red
    g = 1.0 - self.green
    b = 1.0 - self.blue
    a = self.alpha
    if NSColor.respond_to?('colorWithRed:green:blue:alpha:')
      NSColor.colorWithRed(r, green:g, blue:b, alpha:a)
    else
      NSColor.colorWithCalibratedRed(r, green:g, blue:b, alpha:a)
    end
  end

  # Cannot define method `hue' because no Objective-C stub was pre-compiled for
  # types `d@:'. Make sure you properly link with the framework or library that
  # defines this message.
  ### def hue
  ###   hueComponent
  ### rescue Exception
  ###   nil
  ### end

  # Cannot define method `saturation' because no Objective-C stub was
  # pre-compiled for types `d@:'. Make sure you properly link with the framework
  # or library that defines this message.
  ### def saturation
  ###   saturationComponent
  ### rescue Exception
  ###   nil
  ### end

  # Cannot define method `brightness' because no Objective-C stub was
  # pre-compiled for types `d@:'. Make sure you properly link with the framework
  # or library that defines this message.
  ### def brightness
  ###   brightnessComponent
  ### rescue Exception
  ###   nil
  ### end

  def red
    redComponent
  rescue NSInvalidArgumentException
    whiteComponent
  rescue Exception
    nil
  end

  def green
    greenComponent
  rescue NSInvalidArgumentException
    whiteComponent
  rescue Exception
    nil
  end

  def blue
    blueComponent
  rescue NSInvalidArgumentException
    whiteComponent
  rescue Exception
    nil
  end

  def alpha
    alphaComponent
  rescue Exception
    nil
  end

  # returns the components OR'd together, as 32 bit RGB integer. alpha channel
  # is dropped
  def to_i
    if self.red && self.green && self.blue
      red = (self.red * 255).round << 16
      green = (self.green * 255).round << 8
      blue = (self.blue * 255).round
      return red + green + blue
    else
      return nil
    end
  end

  # returns the components as an array of 32 bit RGB values. alpha channel is
  # dropped
  def to_a
    if self.red && self.green && self.blue
      red = (self.red * 255).round
      green = (self.green * 255).round
      blue = (self.blue * 255).round
      return [red, green, blue]
    else
      return nil
    end
  end

  def hex
    my_color = self.to_i
    if my_color
      return '#' + my_color.to_s(16).rjust(6, '0')
    else
      nil
    end
  end

  # returns the closest css name
  def css_name
    my_color = self.to_i
    css_name = nil
    Symbol.css_colors.each do |color, hex|
      if hex == my_color
        css_name = color
        break
      end
    end
    return css_name
  end

  def system_name
    system_color = nil
    Symbol.nscolors.each do |color_name, method|
      color = NSColor.send(method)
      without_alpha = self.nscolor(color.alpha)
      if color == self || color == without_alpha
        system_color = method
        break
      end
    end
    return system_color
  end

end
