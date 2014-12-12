=begin
Example:

    # fonts
    :system.uifont => UIFont.systemFontOfSize(UIFont.systemFontSize)
    :label.uifont => UIFont.systemFontOfSize(UIFont.labelFontSize)

You can extend the defaults by adding entries:

    Symbol.uifontsize[:big] = 40

    :big.uifont => UIFont

=end
class Symbol

  def uifont(size=nil)
    size ||= UIFont.systemFontSize
    # system fonts
    if Symbol.uifont.has_key? self
      font = SugarCube.look_in(self, Symbol.uifont)
      if size.is_a?(Symbol)
        size = size.uifontsize
      end

      if font.is_a?(Symbol)
        return UIFont.send(font, size)
      else
        return font.uifont(size)
      end
    else
      if size.is_a?(Symbol)
          size = size.uifontsize
      end
      return UIFont.systemFontOfSize(size)
    end
  end

  def uifontsize
    size = SugarCube.look_in(self, Symbol.uifontsize)
    if size.is_a?(Symbol)
      return UIFont.send(size)
    end
    return size.to_f
  end

  class << self
    attr :uifont
    attr :uifontsize
  end

  @uifont = {
    system: :"systemFontOfSize:",
    bold:   :"boldSystemFontOfSize:",
    italic: :"italicSystemFontOfSize:",
    monospace: 'Courier New',
  }

  @uifontsize = {
    label:  :labelFontSize,
    button: :buttonFontSize,
    small:  :smallSystemFontSize,
    system: :systemFontSize,
  }


end
