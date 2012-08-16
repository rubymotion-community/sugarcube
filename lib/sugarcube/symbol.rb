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
    attr_accessor :textalignments
    attr_accessor :linebreakmodes
    attr_accessor :baselineadjustments
    attr_accessor :orientations
    attr_accessor :buttontypes
    attr_accessor :bordertypes
    attr_accessor :controlstates
    attr_accessor :controlevents
    attr_accessor :system_fonts
    attr_accessor :font_sizes
    attr_accessor :returnkeys
    attr_accessor :activityindicator_styles
    attr_accessor :tableview_styles
    attr_accessor :statusbar_styles
    attr_accessor :barmetrics
    attr_accessor :barbuttomitems
    attr_accessor :keyboardtypes
  end

  @devices = {
    iphone: UIUserInterfaceIdiomPhone,
    ipad: UIUserInterfaceIdiomPad,
  }

  @textalignments = {
    left: UITextAlignmentLeft,
    right: UITextAlignmentRight,
    center: UITextAlignmentCenter,
  }

  @linebreakmodes = {
    wordwrap: UILineBreakModeWordWrap,
    characterwrap: UILineBreakModeCharacterWrap,
    clip: UILineBreakModeClip,
    headtruncation: UILineBreakModeHeadTruncation,
    tailtruncation: UILineBreakModeTailTruncation,
    middletruncation: UILineBreakModeMiddleTruncation,
  }

  @baselineadjustments = {
    alignbaselines: UIBaselineAdjustmentAlignBaselines,
    aligncenters: UIBaselineAdjustmentAlignCenters,
    none: UIBaselineAdjustmentNone,
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

  @returnkeys = {
    default:       UIReturnKeyDefault,
    go:            UIReturnKeyGo,
    google:        UIReturnKeyGoogle,
    join:          UIReturnKeyJoin,
    next:          UIReturnKeyNext,
    route:         UIReturnKeyRoute,
    search:        UIReturnKeySearch,
    send:          UIReturnKeySend,
    yahoo:         UIReturnKeyYahoo,
    done:          UIReturnKeyDone,
    emergencycall: UIReturnKeyEmergencyCall,
  }

  @activityindicator_styles = {
    large:      UIActivityIndicatorViewStyleWhiteLarge,
    whitelarge: UIActivityIndicatorViewStyleWhiteLarge,
    white:      UIActivityIndicatorViewStyleWhite,
    gray:       UIActivityIndicatorViewStyleGray,
  }

  @tableview_styles = {
    plain:   UITableViewStylePlain,
    grouped: UITableViewStyleGrouped,
  }

  @statusbar_styles = {
    default:   UIStatusBarStyleDefault,
    black:     UIStatusBarStyleBlackOpaque,
    translucent: UIStatusBarStyleBlackTranslucent,
  }

  @barmetrics = {
    default:   UIBarMetricsDefault,
    landscape: UIBarMetricsLandscapePhone,
  }

  @barbuttomitems = {
    done:          UIBarButtonSystemItemDone,
    cancel:        UIBarButtonSystemItemCancel,
    edit:          UIBarButtonSystemItemEdit,
    save:          UIBarButtonSystemItemSave,
    add:           UIBarButtonSystemItemAdd,
    flexiblespace: UIBarButtonSystemItemFlexibleSpace,
    fixedspace:    UIBarButtonSystemItemFixedSpace,
    compose:       UIBarButtonSystemItemCompose,
    reply:         UIBarButtonSystemItemReply,
    action:        UIBarButtonSystemItemAction,
    organize:      UIBarButtonSystemItemOrganize,
    bookmarks:     UIBarButtonSystemItemBookmarks,
    search:        UIBarButtonSystemItemSearch,
    refresh:       UIBarButtonSystemItemRefresh,
    stop:          UIBarButtonSystemItemStop,
    camera:        UIBarButtonSystemItemCamera,
    trash:         UIBarButtonSystemItemTrash,
    play:          UIBarButtonSystemItemPlay,
    pause:         UIBarButtonSystemItemPause,
    rewind:        UIBarButtonSystemItemRewind,
    fastforward:   UIBarButtonSystemItemFastForward,
    undo:          UIBarButtonSystemItemUndo,
    redo:          UIBarButtonSystemItemRedo,
    pagecurl:      UIBarButtonSystemItemPageCurl,
  }

  @keyboardtypes = {
    default:               UIKeyboardTypeDefault,
    asciicapable:          UIKeyboardTypeASCIICapable,
    numbersandpunctuation: UIKeyboardTypeNumbersAndPunctuation,
    url:                   UIKeyboardTypeURL,
    numberpad:             UIKeyboardTypeNumberPad,
    phonepad:              UIKeyboardTypePhonePad,
    namephonepad:          UIKeyboardTypeNamePhonePad,
    emailaddress:          UIKeyboardTypeEmailAddress,
  }

  private
  def look_in(here)
    return here[self] if here.has_key? self
    raise SugarNotFoundException.new(self.inspect)
  end

  public
  def uidevice
    look_in(Symbol.devices)
  end

  def uitextalignment
    look_in(Symbol.textalignments)
  end
  alias :uialignment :uitextalignment

  def uilinebreakmode
    look_in(Symbol.linebreakmodes)
  end

  def uibaselineadjustment
    look_in(Symbol.baselineadjustments)
  end
  alias :uibaseline :uibaselineadjustment

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
  alias :uistate :uicontrolstate

  def uicontrolevent
    look_in(Symbol.controlevents)
  end

  def uireturnkey
    look_in(Symbol.returnkeys)
  end

  def uiactivityindicatorstyle
    look_in(Symbol.activityindicator_styles)
  end
  alias :uiactivityindicatorviewstyle :uiactivityindicatorstyle

  def uitablestyle
    look_in(Symbol.tableview_styles)
  end
  alias :uitableviewstyle :uitablestyle

  def uistatusbarstyle
    look_in(Symbol.statusbar_styles)
  end

  def uibarmetrics
    look_in(Symbol.barmetrics)
  end

  def uibarbuttonitem
    look_in(Symbol.barbuttomitems)
  end

  def uikeyboardtype
    look_in(Symbol.keyboardtypes)
  end

  def uifont(size=UIFont.systemFontSize)
    # system fonts
    if Symbol.system_fonts.has_key? self
      font = look_in(Symbol.system_fonts)
      if Symbol === size
        size = Symbol.font_sizes.fetch(size).uifontsize
      end
      font = UIFont.send(font, size)
    else
      size = look_in(font_sizes).uifontsize
      font = UIFont.systemFontOfSize(size)
    end
    font
  end

  def uifontsize
    size = look_in(Symbol.system_fonts)
    if Symbol === size
      return UIFont.send(Symbol.font_sizes[self])
    end
    return size.to_f
  end

end
