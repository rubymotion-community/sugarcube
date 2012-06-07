=begin
Adds some UI classes to the Symbol class.  These methods are prefixed with `ui`
to make their intent clear, and to provide a little bit of "namespacing"

    # alignment
    :left.uialignment => UITextAlignmentLeft

    # uicolors
    :black.uicolor => UIColor.blackColor

    :darkturquoise.uicolor => UIColor.blackColor

    # fonts
    :system.uifont => UIFont.systemFontOfSize(UIFont.systemFontSize)
    :label.uifont => UIFont.systemFontOfSize(UIFont.labelFontSize)

You can extend the defaults by adding entries:

    Symbol.css_colors[:my_color] = 0x123456
    Symbol.font_sizes[:big] = 40

    :my_color.uicolor => UIColor
    :big.uifont => UIFont
=end
class Symbol
  class << self
    attr_accessor :devices
    attr_accessor :alignments
    attr_accessor :orientations
    attr_accessor :buttontypes
    attr_accessor :bordertypes
    attr_accessor :controlstates
    attr_accessor :controlevents
    attr_accessor :system_fonts
    attr_accessor :font_sizes
    attr_accessor :css_colors
  end

  @devices = {
    iphone: UIUserInterfaceIdiomPhone,
    ipad: UIUserInterfaceIdiomPad,
  }

  @alignments = {
    left: UITextAlignmentLeft,
    right: UITextAlignmentRight,
    center: UITextAlignmentCenter,
  }

  @orientations = {
    portrait: UIInterfaceOrientationPortrait,
    upside_down: UIInterfaceOrientationPortraitUpsideDown,
    left: UIInterfaceOrientationLandscapeLeft,
    right: UIInterfaceOrientationLandscapeRight,
  }

  @buttontypes = {
    custom: UIButtonTypeCustom,
    rounded: UIButtonTypeRoundedRect,
    rounded_rect: UIButtonTypeRoundedRect,
    detail: UIButtonTypeDetailDisclosure,
    detail_disclosure: UIButtonTypeDetailDisclosure,
    info: UIButtonTypeInfoLight,
    info_light: UIButtonTypeInfoLight,
    info_dark: UIButtonTypeInfoDark,
    contact: UIButtonTypeContactAdd,
    contact_add: UIButtonTypeContactAdd,
  }

  @bordertypes = {
    none: UITextBorderStyleNone,
    line: UITextBorderStyleLine,
    bezel: UITextBorderStyleBezel,
    rounded: UITextBorderStyleRoundedRect,
    rounded_rect: UITextBorderStyleRoundedRect,
  }

  @controlstates = {
    normal: UIControlStateNormal,
    highlighted: UIControlStateHighlighted,
    disabled: UIControlStateDisabled,
    selected: UIControlStateSelected,
    application: UIControlStateApplication,
  }

  @controlevents = {
    touch: UIControlEventTouchUpInside,
    touch_down: UIControlEventTouchDown,

    touch_down_repeat: UIControlEventTouchDownRepeat,
    touch_drag_inside: UIControlEventTouchDragInside,
    touch_drag_outside: UIControlEventTouchDragOutside,
    touch_drag_enter: UIControlEventTouchDragEnter,
    touch_drag_exit: UIControlEventTouchDragExit,
    touch_up_inside: UIControlEventTouchUpInside,
    touch_up_outside: UIControlEventTouchUpOutside,
    touch_cancel: UIControlEventTouchCancel,

    value_changed: UIControlEventValueChanged,

    editing_did_begin: UIControlEventEditingDidBegin,
    editing_changed: UIControlEventEditingChanged,
    editing_did_end: UIControlEventEditingDidEnd,
    editing_did_endonexit: UIControlEventEditingDidEndOnExit,

    all_touch: UIControlEventAllTouchEvents,
    all_editing: UIControlEventAllEditingEvents,
    application: UIControlEventApplicationReserved,
    system: UIControlEventSystemReserved,
    all: UIControlEventAllEvents,
  }

  @system_fonts = {
    system: :"systemFontOfSize:",
    bold:   :"boldSystemFontOfSize:",
    italic: :"italicSystemFontOfSize:",
  }

  @font_sizes = {
    label:  :labelFontSize,
    button: :buttonFontSize,
    small:  :smallSystemFontSize,
    system: :systemFontSize,
  }

  private
  def look_in(here)
    return here[self] if here.has_key? self
    raise SugarNotFoundException.new(self)
  end

  public
  def uidevice
    look_in(Symbol.devices)
    if Symbol.devices[self]
      return Symbol.devices[self]
    end
    raise SugarNotFoundException.new(self)
  end

  def uialignment
    look_in(Symbol.alignments)
  end

  def uiorientation
    look_in(Symbol.orientations)
  end

  def uibuttontype
    look_in(Symbol.buttontypes)
  end

  def uibordertype
    look_in(Symbol.bordertypes)
  end

  def uicontrolstate
    look_in(Symbol.controlstates)
  end

  def uicontrolevent
    look_in(Symbol.controlevents)
  end

  def uifont(size=UIFont.systemFontSize)
    # system fonts
    begin
      font = look_in(Symbol.system_fonts)
      if Symbol === size
        size = Symbol.font_sizes.fetch(size).uifontsize
      end
      return UIFont.send(font, size)
    rescue SugarNotFoundException
      size = look_in(font_sizes).uifontsize
      return UIFont.systemFontOfSize(size)
    end
  end

  def uifontsize
    size = look_in(Symbol.system_fonts)
    if Symbol === size
      return UIFont.send(Symbol.font_sizes[self])
    end
    return size.to_f
  end

  def to_teacup_stylesheet
    Teacup::Stylesheet[self]
  end

end
