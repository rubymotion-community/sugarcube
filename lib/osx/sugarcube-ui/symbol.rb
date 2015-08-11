=begin
Example:

    # fonts
    :system.nsfont => NSFont.systemFontOfSize(NSFont.systemFontSize)
    :label.nsfont => NSFont.systemFontOfSize(NSFont.labelFontSize)

You can extend the defaults by adding entries:

    Symbol.nsfontsize[:big] = 40

    :big.nsfont => NSFont

=end
class Symbol

  def nsfont(size=nil)
    size ||= NSFont.systemFontSize
    # system fonts
    if Symbol.nsfont.has_key? self
      font = SugarCube.look_in(self, Symbol.nsfont)
      if size.is_a?(Symbol)
        size = size.nsfontsize
      end

      if font.is_a?(Symbol)
        return NSFont.send(font, size)
      else
        return font.nsfont(size)
      end
    else
      if size.is_a?(Symbol)
          size = size.nsfontsize
      end
      return NSFont.systemFontOfSize(size)
    end
  end

  def nsfontsize
    size = SugarCube.look_in(self, Symbol.nsfontsize)
    if size.is_a?(Symbol)
      return NSFont.send(size)
    end
    return size.to_f
  end

  class << self
    attr :nsfont
    attr :nsfontsize
  end

  @nsfont = {
    system: :"systemFontOfSize:",
    bold:   :"boldSystemFontOfSize:",
    italic: 'Helvetica-Italic',
    monospace: 'Courier New',
  }

  @nsfontsize = {
    label:  :labelFontSize,
    button: :buttonFontSize,
    small:  :smallSystemFontSize,
    system: :systemFontSize,
  }


end
