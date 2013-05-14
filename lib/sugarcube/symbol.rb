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
    Symbol.uifontsize[:big] = 40

    :my_color.uicolor => UIColor
    :big.uifont => UIFont
=end
class Symbol

  def uidevice
    sugarcube_look_in(Symbol.uidevice)
  end

  def uideviceorientation
    sugarcube_look_in(Symbol.uideviceorientation)
  end

  def uiinterfaceorientation
    sugarcube_look_in(Symbol.uiinterfaceorientation)
  end
  alias uiorientation uiinterfaceorientation

  def uiinterfacemask
    sugarcube_look_in(Symbol.uiinterfacemask)
  end

  def uiautoresizemask
    sugarcube_look_in(Symbol.uiautoresizemask, Symbol.uiautoresizemask__deprecated)
  end
  alias uiviewautoresizing uiautoresizemask
  alias uiautoresizingmask uiautoresizemask
  alias uiautoresize uiautoresizemask

  def uireturnkey
    sugarcube_look_in(Symbol.uireturnkey, Symbol.uireturnkey__deprecated)
  end

  def uikeyboardtype
    sugarcube_look_in(Symbol.uikeyboardtype, Symbol.uikeyboardtype__deprecated)
  end

  def uitextalignment
    sugarcube_look_in(Symbol.uitextalignment)
  end
  alias uialignment uitextalignment

  def uilinebreakmode
    sugarcube_look_in(Symbol.uilinebreakmode, Symbol.uilinebreakmode__deprecated)
  end

  def uibaselineadjustment
    sugarcube_look_in(Symbol.uibaselineadjustment)
  end
  alias uibaseline uibaselineadjustment

  def uibordertype
    sugarcube_look_in(Symbol.uibordertype)
  end
  alias uiborderstyle uibordertype

  def nsdatestyle
    sugarcube_look_in(Symbol.nsdatestyle)
  end
  alias nsdateformatterstyle nsdatestyle

  def nsnumberstyle
    sugarcube_look_in(Symbol.nsnumberstyle, Symbol.nsnumberstyle__deprecated)
  end
  alias nsnumberformatterstyle nsnumberstyle

  def uifont(size=nil)
    size ||= UIFont.systemFontSize
    # system fonts
    if Symbol.uifont.has_key? self
      font = sugarcube_look_in(Symbol.uifont)
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
    size = sugarcube_look_in(Symbol.uifontsize)
    if size.is_a?(Symbol)
      return UIFont.send(size)
    end
    return size.to_f
  end

  def uistatusbarstyle
    sugarcube_look_in(Symbol.uistatusbarstyle)
  end

  def uibarmetrics
    sugarcube_look_in(Symbol.uibarmetrics)
  end

  def uibarbuttonitem
    sugarcube_look_in(Symbol.uibarbuttonitem, Symbol.uibarbuttonitem__deprecated)
  end

  def uibarbuttonstyle
    sugarcube_look_in(Symbol.uibarbuttonstyle)
  end

  def uibuttontype
    sugarcube_look_in(Symbol.uibuttontype)
  end

  def uicontrolstate
    sugarcube_look_in(Symbol.uicontrolstate)
  end
  alias uistate uicontrolstate


  def uicontrolevent
    sugarcube_look_in(Symbol.uicontrolevent, Symbol.uicontrolevent__deprecated)
  end

  def uiactivityindicatorstyle
    sugarcube_look_in(Symbol.uiactivityindicatorstyle, Symbol.uiactivityindicatorstyle__deprecated)
  end
  alias uiactivityindicatorviewstyle uiactivityindicatorstyle

  def uisegmentedstyle
    sugarcube_look_in(Symbol.uisegmentedstyle)
  end
  alias uisegmentedcontrolstyle uisegmentedstyle

  def uidatepickermode
    sugarcube_look_in(Symbol.uidatepickermode, Symbol.uidatepickermode__deprecated)
  end

  def uicontentmode
    sugarcube_look_in(Symbol.uicontentmode, Symbol.uicontentmode__deprecated)
  end
  alias uiviewcontentmode uicontentmode

  def uianimationcurve
    sugarcube_look_in(Symbol.uianimationcurve)
  end
  alias uiviewanimationcurve uianimationcurve

  def uitablestyle
    sugarcube_look_in(Symbol.uitablestyle)
  end
  alias uitableviewstyle uitablestyle

  def uitablerowanimation
    sugarcube_look_in(Symbol.uitablerowanimation)
  end
  alias uitableviewrowanimation uitablerowanimation

  def uitablecellstyle
    sugarcube_look_in(Symbol.uitablecellstyle)
  end
  alias uitableviewcellstyle uitablecellstyle

  def uitablecellaccessorytype
    sugarcube_look_in(Symbol.uitablecellaccessorytype, Symbol.uitablecellaccessorytype__deprecated)
  end
  alias uitablecellaccessory uitablecellaccessorytype
  alias uitableviewcellaccessorytype uitablecellaccessorytype

  def uitablecellselectionstyle
    sugarcube_look_in(Symbol.uitablecellselectionstyle)
  end
  alias uitableviewcellselectionstyle uitablecellselectionstyle

  def uitablecellseparatorstyle
    sugarcube_look_in(Symbol.uitablecellseparatorstyle, Symbol.uitablecellseparatorstyle__deprecated)
  end

  def uialertstyle
    sugarcube_look_in(Symbol.uialertstyle)
  end
  alias uialertviewstyle uialertstyle

  def uiactionstyle
    sugarcube_look_in(Symbol.uiactionstyle)
  end
  alias uiactionsheetstyle uiactionstyle

  def uiimagesource
    sugarcube_look_in(Symbol.uiimagesource)
  end
  alias uiimagesourcetype uiimagesource

  def uiimagecapture
    sugarcube_look_in(Symbol.uiimagecapture)
  end
  alias uiimagecapturemode uiimagecapture

  def uiimagecamera
    sugarcube_look_in(Symbol.uiimagecamera)
  end
  alias uiimagecameradevice uiimagecamera
  alias uiimagedevice uiimagecamera

  def uiimagequality
    sugarcube_look_in(Symbol.uiimagequality)
  end
  alias uiimagequalitytype uiimagequality

  def catimingfunction
    sugarcube_look_in(Symbol.catimingfunction, Symbol.catimingfunction__deprecated)
  end
  alias catiming catimingfunction

  def cglinecap
    sugarcube_look_in(Symbol.cglinecap)
  end
  alias cglinecapstyle cglinecap

  def cglinejoin
    sugarcube_look_in(Symbol.cglinejoin)
  end
  alias cglinejoinstyle cglinejoin

  def uigesturerecognizerstate
    sugarcube_look_in(Symbol.uigesturerecognizerstate)
  end
  alias uigesturestate uigesturerecognizerstate

  class << self
    attr :uidevice
    attr :uideviceorientation
    attr :uiinterfaceorientation
    attr :uiinterfacemask
    attr :uiautoresizemask
    attr :uiautoresizemask__deprecated

    attr :uireturnkey
    attr :uireturnkey__deprecated
    attr :uikeyboardtype
    attr :uikeyboardtype__deprecated
    attr :uitextalignment
    attr :uilinebreakmode
    attr :uilinebreakmode__deprecated
    attr :uibaselineadjustment
    attr :uibordertype
    attr :nsdatestyle
    attr :nsnumberstyle
    attr :nsnumberstyle__deprecated

    attr :uifont
    attr :uifontsize

    attr :uistatusbarstyle
    attr :uibarmetrics
    attr :uibarbuttonitem
    attr :uibarbuttonitem__deprecated
    attr :uibarbuttonstyle

    attr :uibuttontype
    attr :uicontrolstate
    attr :uicontrolevent
    attr :uicontrolevent__deprecated
    attr :uiactivityindicatorstyle
    attr :uiactivityindicatorstyle__deprecated
    attr :uisegmentedstyle
    attr :uidatepickermode
    attr :uidatepickermode__deprecated
    attr :uicontentmode
    attr :uicontentmode__deprecated
    attr :uianimationcurve

    attr :uitablestyle
    attr :uitablerowanimation
    attr :uitablecellstyle
    attr :uitablecellaccessorytype
    attr :uitablecellaccessorytype__deprecated
    attr :uitablecellselectionstyle
    attr :uitablecellseparatorstyle
    attr :uitablecellseparatorstyle__deprecated

    attr :uialertstyle
    attr :uiactionstyle

    attr :uiimagesource
    attr :uiimagecapture
    attr :uiimagecamera
    attr :uiimagequality

    attr :catimingfunction
    attr :catimingfunction__deprecated

    attr :cglinecap
    attr :cglinejoin

    attr :uigesturerecognizerstate

  end

  @uidevice = {
    iphone: UIUserInterfaceIdiomPhone,
    ipad:   UIUserInterfaceIdiomPad,
  }

  @uideviceorientation = {
    unknown:     UIDeviceOrientationUnknown,
    portrait:    UIDeviceOrientationPortrait,
    upside_down: UIDeviceOrientationPortraitUpsideDown,
    left:        UIDeviceOrientationLandscapeLeft,
    right:       UIDeviceOrientationLandscapeRight,
    face_up:     UIDeviceOrientationFaceUp,
    face_down:   UIDeviceOrientationFaceDown
  }

  @uiinterfaceorientation = {
    portrait:    UIInterfaceOrientationPortrait,
    upside_down: UIInterfaceOrientationPortraitUpsideDown,
    left:        UIInterfaceOrientationLandscapeLeft,
    right:       UIInterfaceOrientationLandscapeRight,
  }

  @uiinterfacemask = {
    portrait:            UIInterfaceOrientationMaskPortrait,
    landscrape:          UIInterfaceOrientationMaskLandscape,
    left:                UIInterfaceOrientationMaskLandscapeLeft,
    right:               UIInterfaceOrientationMaskLandscapeRight,
    upside_down:         UIInterfaceOrientationMaskPortraitUpsideDown,
    all_but_upside_down: UIInterfaceOrientationMaskAllButUpsideDown,
    iphone:              UIInterfaceOrientationMaskAllButUpsideDown,
    all:                 UIInterfaceOrientationMaskAll,
    ipad:                UIInterfaceOrientationMaskAll,
  }

  @uiautoresizemask__deprecated = {
    full: :fill,
    fixed_top: :fill_top,
    fixed_bottom: :fill_bottom,
    fixed_left: :fill_left,
    fixed_right: :fill_right,
  }
  @uiautoresizemask = {
    none: UIViewAutoresizingNone,
    flexible_left:   UIViewAutoresizingFlexibleLeftMargin,
    flexible_width:  UIViewAutoresizingFlexibleWidth,
    flexible_right:  UIViewAutoresizingFlexibleRightMargin,
    flexible_top:    UIViewAutoresizingFlexibleTopMargin,
    flexible_height: UIViewAutoresizingFlexibleHeight,
    flexible_bottom: UIViewAutoresizingFlexibleBottomMargin,
    fill:        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight,
    fill_top:    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin,
    fill_bottom: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin,
    fill_left:   UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin,
    fill_right:  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin,
    fixed_top_left:      UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin,
    fixed_top_middle:    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin,
    fixed_top_right:     UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin,
    fixed_middle_left:   UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin,
    fixed_middle:        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin,
    fixed_middle_right:  UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin,
    fixed_bottom_left:   UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin,
    fixed_bottom_middle: UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin,
    fixed_bottom_right:  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin,
    float_horizontal: UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin,
    float_vertical:   UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin,
  }

  @uireturnkey__deprecated = {
    emergencycall: :emergency_call
  }
  @uireturnkey = {
    default:        UIReturnKeyDefault,
    return:         UIReturnKeyDefault,
    go:             UIReturnKeyGo,
    google:         UIReturnKeyGoogle,
    join:           UIReturnKeyJoin,
    next:           UIReturnKeyNext,
    route:          UIReturnKeyRoute,
    search:         UIReturnKeySearch,
    send:           UIReturnKeySend,
    yahoo:          UIReturnKeyYahoo,
    done:           UIReturnKeyDone,
    emergency_call: UIReturnKeyEmergencyCall,
  }

  @uikeyboardtype__deprecated = {
    asciicapable:          :ascii_capable,
    numbersandpunctuation: :numbers_and_punctuation,
    numberpad:             :number_pad,
    phonepad:              :phone_pad,
    namephonepad:          :name_phone_pad,
    nameandphone:          :name_and_phone,
    emailaddress:          :email_address,
  }
  @uikeyboardtype = {
    default:                 UIKeyboardTypeDefault,
    ascii_capable:           UIKeyboardTypeASCIICapable,
    ascii:                   UIKeyboardTypeASCIICapable,
    numbers_and_punctuation: UIKeyboardTypeNumbersAndPunctuation,
    url:                     UIKeyboardTypeURL,
    number_pad:              UIKeyboardTypeNumberPad,
    number:                  UIKeyboardTypeNumberPad,
    phone_pad:               UIKeyboardTypePhonePad,
    phone:                   UIKeyboardTypePhonePad,
    name_phone_pad:          UIKeyboardTypeNamePhonePad,
    name_and_phone:          UIKeyboardTypeNamePhonePad,
    email_address:           UIKeyboardTypeEmailAddress,
    email:                   UIKeyboardTypeEmailAddress,
  }

  @uitextalignment = {
    left:   UITextAlignmentLeft,
    right:  UITextAlignmentRight,
    center: UITextAlignmentCenter,
  }

  @uilinebreakmode__deprecated = {
    wordwrap: :word_wrap,
    characterwrap: :character_wrap,
    headtruncation: :head_truncation,
    tailtruncation: :tail_truncation,
    middletruncation: :middle_truncation,
  }
  @uilinebreakmode = {
    word_wrap:         UILineBreakModeWordWrap,
    character_wrap:    UILineBreakModeCharacterWrap,
    clip:              UILineBreakModeClip,
    head_truncation:   UILineBreakModeHeadTruncation,
    tail_truncation:   UILineBreakModeTailTruncation,
    middle_truncation: UILineBreakModeMiddleTruncation,
  }

  @uibaselineadjustment = {
    alignbaselines: UIBaselineAdjustmentAlignBaselines,
    aligncenters:   UIBaselineAdjustmentAlignCenters,
    none:           UIBaselineAdjustmentNone,
  }

  @uibordertype = {
    none:         UITextBorderStyleNone,
    line:         UITextBorderStyleLine,
    bezel:        UITextBorderStyleBezel,
    rounded:      UITextBorderStyleRoundedRect,
    rounded_rect: UITextBorderStyleRoundedRect,
  }

  @nsdatestyle = {
    no:     NSDateFormatterNoStyle,
    none:   NSDateFormatterNoStyle,
    short:  NSDateFormatterShortStyle,
    medium: NSDateFormatterMediumStyle,
    long:   NSDateFormatterLongStyle,
    full:   NSDateFormatterFullStyle,
  }

  @nsnumberstyle__deprecated = {
    spellout: :spell_out,
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

  @uistatusbarstyle = {
    default:     UIStatusBarStyleDefault,
    black:       UIStatusBarStyleBlackOpaque,
    translucent: UIStatusBarStyleBlackTranslucent,
  }

  @uibarmetrics = {
    default:   UIBarMetricsDefault,
    landscape: UIBarMetricsLandscapePhone,
  }

  @uibarbuttonitem__deprecated = {
    flexiblespace: :flexible_space,
    fixedspace:    :fixed_space,
    fastforward:   :fast_forward,
  }
  @uibarbuttonitem = {
    done:           UIBarButtonSystemItemDone,
    cancel:         UIBarButtonSystemItemCancel,
    edit:           UIBarButtonSystemItemEdit,
    save:           UIBarButtonSystemItemSave,
    add:            UIBarButtonSystemItemAdd,
    flexible_space: UIBarButtonSystemItemFlexibleSpace,
    fixed_space:    UIBarButtonSystemItemFixedSpace,
    compose:        UIBarButtonSystemItemCompose,
    reply:          UIBarButtonSystemItemReply,
    action:         UIBarButtonSystemItemAction,
    organize:       UIBarButtonSystemItemOrganize,
    bookmarks:      UIBarButtonSystemItemBookmarks,
    search:         UIBarButtonSystemItemSearch,
    refresh:        UIBarButtonSystemItemRefresh,
    stop:           UIBarButtonSystemItemStop,
    camera:         UIBarButtonSystemItemCamera,
    trash:          UIBarButtonSystemItemTrash,
    play:           UIBarButtonSystemItemPlay,
    pause:          UIBarButtonSystemItemPause,
    rewind:         UIBarButtonSystemItemRewind,
    fast_forward:   UIBarButtonSystemItemFastForward,
    undo:           UIBarButtonSystemItemUndo,
    redo:           UIBarButtonSystemItemRedo,
    pagecurl:       UIBarButtonSystemItemPageCurl,
  }

  @uibarbuttonstyle = {
    plain:    UIBarButtonItemStylePlain,
    bordered: UIBarButtonItemStyleBordered,
    done:     UIBarButtonItemStyleDone
  }

  @uibuttontype = {
    custom:            UIButtonTypeCustom,
    rounded:           UIButtonTypeRoundedRect,
    rounded_rect:      UIButtonTypeRoundedRect,
    detail:            UIButtonTypeDetailDisclosure,
    detail_disclosure: UIButtonTypeDetailDisclosure,
    info:              UIButtonTypeInfoLight,
    info_light:        UIButtonTypeInfoLight,
    info_dark:         UIButtonTypeInfoDark,
    contact:           UIButtonTypeContactAdd,
    contact_add:       UIButtonTypeContactAdd,
  }

  @uicontrolstate = {
    normal:      UIControlStateNormal,
    highlighted: UIControlStateHighlighted,
    disabled:    UIControlStateDisabled,
    selected:    UIControlStateSelected,
    application: UIControlStateApplication,
  }

  @uicontrolevent__deprecated = {
    changed: :change,
    editing_did_endonexit: :editing_did_end_on_exit,
  }
  @uicontrolevent = {
    touch:       UIControlEventTouchUpInside,
    touch_up:    UIControlEventTouchUpInside,
    touch_down:  UIControlEventTouchDown,
    touch_start: UIControlEventTouchDown | UIControlEventTouchDragEnter,
    touch_stop:  UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchDragExit,
    change:      UIControlEventValueChanged | UIControlEventEditingChanged,
    begin:       UIControlEventEditingDidBegin,
    end:         UIControlEventEditingDidEnd,

    touch_down_repeat:  UIControlEventTouchDownRepeat,
    touch_drag_inside:  UIControlEventTouchDragInside,
    touch_drag_outside: UIControlEventTouchDragOutside,
    touch_drag_enter:   UIControlEventTouchDragEnter,
    touch_drag_exit:    UIControlEventTouchDragExit,
    touch_up_inside:    UIControlEventTouchUpInside,
    touch_up_outside:   UIControlEventTouchUpOutside,
    touch_cancel:       UIControlEventTouchCancel,

    value_changed: UIControlEventValueChanged,

    editing_did_begin:       UIControlEventEditingDidBegin,
    # nice.  very consistent APPLE:
    editing_changed:         UIControlEventEditingChanged,
    # now here's consistency:
    editing_did_change:      UIControlEventEditingChanged,
    editing_did_end:         UIControlEventEditingDidEnd,
    editing_did_end_on_exit: UIControlEventEditingDidEndOnExit,

    all_touch:   UIControlEventAllTouchEvents,
    all_editing: UIControlEventAllEditingEvents,
    application: UIControlEventApplicationReserved,
    system:      UIControlEventSystemReserved,
    all:         UIControlEventAllEvents,
  }

  @uiactivityindicatorstyle__deprecated = {
    whitelarge: :white_large,
  }
  @uiactivityindicatorstyle = {
    large:       UIActivityIndicatorViewStyleWhiteLarge,
    white_large: UIActivityIndicatorViewStyleWhiteLarge,
    white:       UIActivityIndicatorViewStyleWhite,
    gray:        UIActivityIndicatorViewStyleGray,
  }

  @uisegmentedstyle = {
    plain:    UISegmentedControlStylePlain,
    bordered: UISegmentedControlStyleBordered,
    bar:      UISegmentedControlStyleBar,
    bezeled:  UISegmentedControlStyleBezeled,
  }

  @uidatepickermode__deprecated = {
    dateandtime: :date_and_time,
    countdowntimer: :count_down_timer,
  }
  @uidatepickermode = {
    time:             UIDatePickerModeTime,
    date:             UIDatePickerModeDate,
    date_and_time:    UIDatePickerModeDateAndTime,
    count_down_timer: UIDatePickerModeCountDownTimer
  }

  @uicontentmode__deprecated = {
    scaletofill: :scale_to_fill,
    scaleaspectfit: :scale_aspect_fit,
    scaleaspectfill: :scale_aspect_fill,
    topleft: :top_left,
    topright: :top_right,
    bottomleft: :bottom_left,
    bottomright: :bottom_right,
  }
  @uicontentmode = {
    scale:             UIViewContentModeScaleToFill,
    scale_to_fill:     UIViewContentModeScaleToFill,
    fit:               UIViewContentModeScaleAspectFit,
    scale_aspect_fit:  UIViewContentModeScaleAspectFit,
    fill:              UIViewContentModeScaleAspectFill,
    scale_aspect_fill: UIViewContentModeScaleAspectFill,
    redraw:            UIViewContentModeRedraw,
    center:            UIViewContentModeCenter,
    top:               UIViewContentModeTop,
    bottom:            UIViewContentModeBottom,
    left:              UIViewContentModeLeft,
    right:             UIViewContentModeRight,
    top_left:          UIViewContentModeTopLeft,
    top_right:         UIViewContentModeTopRight,
    bottom_left:       UIViewContentModeBottomLeft,
    bottom_right:      UIViewContentModeBottomRight,
  }

  @uianimationcurve = {
    ease_in_out: UIViewAnimationCurveEaseInOut,
    ease_in:     UIViewAnimationCurveEaseIn,
    ease_out:    UIViewAnimationCurveEaseOut,
    linear:      UIViewAnimationCurveLinear
  }

  @uitablestyle = {
    plain:   UITableViewStylePlain,
    grouped: UITableViewStyleGrouped,
  }

  @uitablerowanimation = {
    fade:      UITableViewRowAnimationFade,
    right:     UITableViewRowAnimationRight,
    left:      UITableViewRowAnimationLeft,
    top:       UITableViewRowAnimationTop,
    bottom:    UITableViewRowAnimationBottom,
    none:      UITableViewRowAnimationNone,
    middle:    UITableViewRowAnimationMiddle,
    automatic: UITableViewRowAnimationAutomatic,
  }

  @uitablecellstyle = {
    default:  UITableViewCellStyleDefault,
    value1:   UITableViewCellStyleValue1,
    value2:   UITableViewCellStyleValue2,
    subtitle: UITableViewCellStyleSubtitle,
  }

  @uitablecellaccessorytype__deprecated = {
    disclosureindicator: :disclosure_indicator,
    detaildisclosurebutton: :detail_disclosure_button,
  }
  @uitablecellaccessorytype = {
    none:                     UITableViewCellAccessoryNone,
    disclosure:               UITableViewCellAccessoryDisclosureIndicator,
    disclosure_indicator:     UITableViewCellAccessoryDisclosureIndicator,
    detail:                   UITableViewCellAccessoryDetailDisclosureButton,
    detail_disclosure_button: UITableViewCellAccessoryDetailDisclosureButton,
    checkmark:                UITableViewCellAccessoryCheckmark,
  }

  @uitablecellselectionstyle = {
    none: UITableViewCellSelectionStyleNone,
    blue: UITableViewCellSelectionStyleBlue,
    gray: UITableViewCellSelectionStyleGray,
  }

  @uitablecellseparatorstyle__deprecated = {
    singleline: :single_line,
    singlelineetched: :single_line_etched,
  }
  @uitablecellseparatorstyle = {
    none:               UITableViewCellSeparatorStyleNone,
    single_line:        UITableViewCellSeparatorStyleSingleLine,
    single:             UITableViewCellSeparatorStyleSingleLine,
    single_line_etched: UITableViewCellSeparatorStyleSingleLineEtched,
    etched:             UITableViewCellSeparatorStyleSingleLineEtched,
  }

  @uialertstyle = {
    default:                  UIAlertViewStyleDefault,
    secure_text_input:        UIAlertViewStyleSecureTextInput,
    plain_text_input:         UIAlertViewStylePlainTextInput,
    login_and_password_input: UIAlertViewStyleLoginAndPasswordInput,
  }

  @uiactionstyle = {
    automatic:         UIActionSheetStyleAutomatic,
    default:           UIActionSheetStyleDefault,
    black_translucent: UIActionSheetStyleBlackTranslucent,
    black_opaque:      UIActionSheetStyleBlackOpaque,
  }

  @uiimagesource = {
    camera:  UIImagePickerControllerSourceTypeCamera,
    library: UIImagePickerControllerSourceTypePhotoLibrary,
    album:   UIImagePickerControllerSourceTypeSavedPhotosAlbum,
  }

  @uiimagecapture = {
    photo: UIImagePickerControllerCameraCaptureModePhoto,
    video: UIImagePickerControllerCameraCaptureModeVideo,
  }

  @uiimagecamera = {
    front: UIImagePickerControllerCameraDeviceFront,
    rear:  UIImagePickerControllerCameraDeviceRear,
  }

  @uiimagequality = {
    high:       UIImagePickerControllerQualityTypeHigh,
    medium:     UIImagePickerControllerQualityTypeMedium,
    low:        UIImagePickerControllerQualityTypeLow,
    vga:        UIImagePickerControllerQualityType640x480,
    i1280x720:  UIImagePickerControllerQualityTypeIFrame1280x720,
    i1280:      UIImagePickerControllerQualityTypeIFrame1280x720,
    i720:       UIImagePickerControllerQualityTypeIFrame1280x720,
    i960x540:   UIImagePickerControllerQualityTypeIFrame960x540,
    i960:       UIImagePickerControllerQualityTypeIFrame960x540,
    i540:       UIImagePickerControllerQualityTypeIFrame960x540,
  }

  @catimingfunction__deprecated = {
    easein:    :ease_in,
    easeout:   :ease_out,
    easeinout: :ease_in_out,
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

  @uigesturerecognizerstate = {
    possible:   UIGestureRecognizerStatePossible,
    began:      UIGestureRecognizerStateBegan,
    changed:    UIGestureRecognizerStateChanged,
    ended:      UIGestureRecognizerStateEnded,
    cancelled:  UIGestureRecognizerStateCancelled,
    failed:     UIGestureRecognizerStateFailed,
    recognized: UIGestureRecognizerStateRecognized,
  }

  private
  def sugarcube_look_in(here, here__deprecated={})
    return here[self] if here.has_key? self
    if here__deprecated[self]
      translated = here__deprecated[self]
      message = "The symbol #{self.inspect} has been deprecated in favor of #{translated.inspect}"
      if defined?(SugarCube::Legacy)
        SugarCube::Legacy.log(message)
      else
        NSLog(message)
      end
      return here[translated]
    end
    raise SugarCubeNotFoundException.new(self.inspect)
  end

end
