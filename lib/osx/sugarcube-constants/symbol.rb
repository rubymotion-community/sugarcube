=begin
Adds constant lookups to the Symbol class.  These methods are prefixed with `ns`
to make their intent clear, and to provide a little bit of "namespacing"

    # alignment
    :left.nsalignment => NSLeftTextAlignment

    # nscolors
    :black.nscolor => NSColor.blackColor

You can extend the defaults by adding entries:

    Symbol.css_colors[:my_color] = 0x123456

    :my_color.nscolor => NSColor
=end
class Symbol

  def nsautoresizingmask
    SugarCube.look_in(self, Symbol.nsautoresizingmask)
  end
  alias nsautoresizemask nsautoresizingmask

  def nstextalignment
    SugarCube.look_in(self, Symbol.nstextalignment)
  end
  alias nsalignment nstextalignment

  def nsdatestyle
    SugarCube.look_in(self, Symbol.nsdatestyle)
  end
  alias nsdateformatterstyle nsdatestyle

  def nsnumberstyle
    SugarCube.look_in(self, Symbol.nsnumberstyle)
  end
  alias nsnumberformatterstyle nsnumberstyle

  def nsbuttontype
    SugarCube.look_in(self, Symbol.nsbuttontype)
  end

  def nsbezelstyle
    SugarCube.look_in(self, Symbol.nsbezelstyle)
  end

  def nsfocusringtype
    SugarCube.look_in(self, Symbol.nsfocusringtype)
  end

  def nslinebreakmode
    SugarCube.look_in(self, Symbol.nslinebreakmode)
  end
  alias nslinebreak nslinebreakmode

  def catimingfunction
    SugarCube.look_in(self, Symbol.catimingfunction)
  end
  alias catiming catimingfunction

  def cglinecap
    SugarCube.look_in(self, Symbol.cglinecap)
  end
  alias cglinecapstyle cglinecap

  def cglinejoin
    SugarCube.look_in(self, Symbol.cglinejoin)
  end
  alias cglinejoinstyle cglinejoin

  class << self
    attr :nsautoresizingmask
    attr :nstextalignment
    attr :nsdatestyle
    attr :nsnumberstyle
    attr :nsbuttontype
    attr :nsbezelstyle
    attr :nsfocusringtype
    attr :nslinebreakmode
    attr :catimingfunction
    attr :cglinecap
    attr :cglinejoin
  end

  @nsautoresizingmask = {
    none: NSViewNotSizable,
    flexible_left:   NSViewMinXMargin,
    flexible_width:  NSViewWidthSizable,
    flexible_right:  NSViewMaxXMargin,
    flexible_top:    NSViewMaxYMargin,
    flexible_height: NSViewHeightSizable,
    flexible_bottom: NSViewMinYMargin,
    fill:        NSViewWidthSizable | NSViewHeightSizable,
    fill_top:    NSViewWidthSizable | NSViewMinYMargin,
    fill_bottom: NSViewWidthSizable | NSViewMaxYMargin,
    fill_left:   NSViewHeightSizable | NSViewMaxXMargin,
    fill_right:  NSViewHeightSizable | NSViewMinXMargin,
    fixed_top_left:      NSViewMaxXMargin | NSViewMinYMargin,
    fixed_top_middle:    NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin,
    fixed_top_right:     NSViewMinXMargin | NSViewMinYMargin,
    fixed_middle_left:   NSViewMaxYMargin | NSViewMinYMargin | NSViewMaxXMargin,
    fixed_middle:        NSViewMaxYMargin | NSViewMinYMargin | NSViewMinXMargin | NSViewMaxXMargin,
    fixed_middle_right:  NSViewMaxYMargin | NSViewMinYMargin | NSViewMinXMargin,
    fixed_bottom_left:   NSViewMaxXMargin | NSViewMaxYMargin,
    fixed_bottom_middle: NSViewMinXMargin | NSViewMaxXMargin | NSViewMaxYMargin,
    fixed_bottom_right:  NSViewMinXMargin | NSViewMaxYMargin,
    float_horizontal: NSViewMinXMargin | NSViewMaxXMargin,
    float_vertical:   NSViewMaxYMargin | NSViewMinYMargin,
  }

  @nstextalignment = {
    left:   NSLeftTextAlignment,
    right:  NSRightTextAlignment,
    center: NSCenterTextAlignment,
  }

  @nsdatestyle = {
    no:     NSDateFormatterNoStyle,
    none:   NSDateFormatterNoStyle,
    short:  NSDateFormatterShortStyle,
    medium: NSDateFormatterMediumStyle,
    long:   NSDateFormatterLongStyle,
    full:   NSDateFormatterFullStyle,
  }

  @nsnumberstyle = {
    no:         NSNumberFormatterNoStyle,
    none:       NSNumberFormatterNoStyle,
    decimal:    NSNumberFormatterDecimalStyle,
    currency:   NSNumberFormatterCurrencyStyle,
    percent:    NSNumberFormatterPercentStyle,
    scientific: NSNumberFormatterScientificStyle,
    spell_out:  NSNumberFormatterSpellOutStyle,
  }

  @nsbuttontype = {
    momentary_light:   NSMomentaryLightButton,
    push_on_push_off:  NSPushOnPushOffButton,
    toggle:            NSToggleButton,
    switch:            NSSwitchButton,
    radio:             NSRadioButton,
    momentary_change:  NSMomentaryChangeButton,
    on_off:            NSOnOffButton,
    momentary_push_in: NSMomentaryPushInButton,
  }

  @nsbezelstyle = {
    rounded:            NSRoundedBezelStyle,
    regular_square:     NSRegularSquareBezelStyle,
    thick_square:       NSThickSquareBezelStyle,
    thicker_square:     NSThickerSquareBezelStyle,
    disclosure:         NSDisclosureBezelStyle,
    shadowless_square:  NSShadowlessSquareBezelStyle,
    circular:           NSCircularBezelStyle,
    textured_square:    NSTexturedSquareBezelStyle,
    help_button:        NSHelpButtonBezelStyle,
    small_square:       NSSmallSquareBezelStyle,
    textured_rounded:   NSTexturedRoundedBezelStyle,
    round_rect:         NSRoundRectBezelStyle,
    recessed:           NSRecessedBezelStyle,
    rounded_disclosure: NSRoundedDisclosureBezelStyle,
    inline:             NSInlineBezelStyle,
  }

  @nsfocusringtype = {
    default:   NSFocusRingTypeDefault,
    none:      NSFocusRingTypeNone,
    exterior:  NSFocusRingTypeExterior,
  }

  @nslinebreakmode = {
    word_wrapping:     NSLineBreakByWordWrapping,
    word_wrap:         NSLineBreakByWordWrapping,
    word:              NSLineBreakByWordWrapping,
    char_wrapping:     NSLineBreakByCharWrapping,
    char_wrap:         NSLineBreakByCharWrapping,
    char:              NSLineBreakByCharWrapping,
    clipping:          NSLineBreakByClipping,
    clip:              NSLineBreakByClipping,
    truncating_head:   NSLineBreakByTruncatingHead,
    head:              NSLineBreakByTruncatingHead,
    truncating_tail:   NSLineBreakByTruncatingTail,
    tail:              NSLineBreakByTruncatingTail,
    truncating_middle: NSLineBreakByTruncatingMiddle,
    middle:            NSLineBreakByTruncatingMiddle
  }

  @catimingfunction = {
    linear:            KCAMediaTimingFunctionLinear,
    ease_in:           KCAMediaTimingFunctionEaseIn,
    ease_out:          KCAMediaTimingFunctionEaseOut,
    ease_in_out:       KCAMediaTimingFunctionEaseInEaseOut,
    ease_in_ease_out:  KCAMediaTimingFunctionEaseInEaseOut,
    default:           KCAMediaTimingFunctionDefault,
  }

  @cglinecap = {
    butt:   KCGLineCapButt,
    round:  KCGLineCapRound,
    square: KCGLineCapSquare,
  }

  @cglinejoin = {
    miter: KCGLineJoinMiter,
    round: KCGLineJoinRound,
    bevel: KCGLineJoinBevel,
  }

end
