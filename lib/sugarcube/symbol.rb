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
    attr_accessor :device_orientations
    attr_accessor :interface_orientations
    attr_accessor :interface_masks
    attr_accessor :orientations
    attr_accessor :returnkeys
    attr_accessor :statusbar_styles
    attr_accessor :barmetrics
    attr_accessor :barbuttomitems
    attr_accessor :keyboardtypes
    attr_accessor :autoresizemasks

    attr_accessor :textalignments
    attr_accessor :linebreakmodes
    attr_accessor :baselineadjustments
    attr_accessor :system_fonts
    attr_accessor :font_sizes
    attr_accessor :date_styles
    attr_accessor :number_styles

    attr_accessor :buttontypes
    attr_accessor :border_types
    attr_accessor :control_states
    attr_accessor :control_events
    attr_accessor :activityindicator_styles
    attr_accessor :segmented_styles
    attr_accessor :datepicker_modes
    attr_accessor :content_modes

    attr_accessor :tableview_styles
    attr_accessor :tableview_rowanimation
    attr_accessor :tableview_cellstyles
    attr_accessor :tableview_cellaccessorytype
    attr_accessor :tableview_cellselectionstyle
    attr_accessor :tableview_cellseparatorstyle

    attr_accessor :image_sourcetypes
    attr_accessor :image_capturemode
    attr_accessor :image_cameradevice
    attr_accessor :image_quality

    attr_accessor :ca_timingfunctions

    attr_accessor :cg_linecapstyles
    attr_accessor :cg_linejoinstyles

    attr_accessor :gesture_recognizer_states
  end

  @devices = {
    iphone: UIUserInterfaceIdiomPhone,
    ipad: UIUserInterfaceIdiomPad,
  }

  @device_orientations = {
    unknown: UIDeviceOrientationUnknown,
    portrait: UIDeviceOrientationPortrait,
    upside_down: UIDeviceOrientationPortraitUpsideDown,
    left: UIDeviceOrientationLandscapeLeft,
    right: UIDeviceOrientationLandscapeRight,
    face_up: UIDeviceOrientationFaceUp,
    face_down: UIDeviceOrientationFaceDown
  }

  @interface_orientations = {
    portrait: UIInterfaceOrientationPortrait,
    upside_down: UIInterfaceOrientationPortraitUpsideDown,
    left: UIInterfaceOrientationLandscapeLeft,
    right: UIInterfaceOrientationLandscapeRight,
  }

  @interface_masks = {
    portrait: UIInterfaceOrientationMaskPortrait,
    landscrape: UIInterfaceOrientationMaskLandscape,
    left: UIInterfaceOrientationMaskLandscapeLeft,
    right: UIInterfaceOrientationMaskLandscapeRight,
    upside_down: UIInterfaceOrientationMaskPortraitUpsideDown,
    all_but_upside_down: UIInterfaceOrientationMaskAllButUpsideDown,
    iphone: UIInterfaceOrientationMaskAllButUpsideDown,
    all: UIInterfaceOrientationMaskAll,
    ipad: UIInterfaceOrientationMaskAll,
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

  @border_types = {
    none: UITextBorderStyleNone,
    line: UITextBorderStyleLine,
    bezel: UITextBorderStyleBezel,
    rounded: UITextBorderStyleRoundedRect,
    rounded_rect: UITextBorderStyleRoundedRect,
  }

  @control_states = {
    normal: UIControlStateNormal,
    highlighted: UIControlStateHighlighted,
    disabled: UIControlStateDisabled,
    selected: UIControlStateSelected,
    application: UIControlStateApplication,
  }

  @control_events = {
    touch: UIControlEventTouchUpInside,
    touch_up: UIControlEventTouchUpInside,
    touch_down: UIControlEventTouchDown,
    touch_start: UIControlEventTouchDown | UIControlEventTouchDragEnter,
    touch_stop: UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchDragExit,
    change:  UIControlEventValueChanged | UIControlEventEditingChanged,
    begin: UIControlEventEditingDidBegin,
    end: UIControlEventEditingDidEnd,
    # I'm leaving this for backwards compatibility.  please use 'change' or
    # 'editing_did_change':
    changed: UIControlEventValueChanged | UIControlEventEditingChanged,

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
    # nice.  very consistent APPLE:
    editing_changed: UIControlEventEditingChanged,
    # now here's consistency:
    editing_did_change: UIControlEventEditingChanged,
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

  @date_styles = {
    no: NSDateFormatterNoStyle,
    none: NSDateFormatterNoStyle,
    short: NSDateFormatterShortStyle,
    medium: NSDateFormatterMediumStyle,
    long: NSDateFormatterLongStyle,
    full: NSDateFormatterFullStyle,
  }

  @number_styles = {
    no: NSNumberFormatterNoStyle,
    none: NSNumberFormatterNoStyle,
    decimal: NSNumberFormatterDecimalStyle,
    currency: NSNumberFormatterCurrencyStyle,
    percent: NSNumberFormatterPercentStyle,
    scientific: NSNumberFormatterScientificStyle,
    spellout: NSNumberFormatterSpellOutStyle,
    spell_out: NSNumberFormatterSpellOutStyle,
  }

  @returnkeys = {
    default:       UIReturnKeyDefault,
    return:        UIReturnKeyDefault,
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

  @segmented_styles = {
    plain: UISegmentedControlStylePlain,
    bordered: UISegmentedControlStyleBordered,
    bar: UISegmentedControlStyleBar,
    bezeled: UISegmentedControlStyleBezeled,
  }

  @datepicker_modes = {
    time:           UIDatePickerModeTime,
    date:           UIDatePickerModeDate,
    dateandtime:    UIDatePickerModeDateAndTime,
    countdowntimer: UIDatePickerModeCountDownTimer
  }

  @content_modes = {
    scale: UIViewContentModeScaleToFill,
    scale_to_fill: UIViewContentModeScaleToFill,
    scaletofill: UIViewContentModeScaleToFill,
    fit: UIViewContentModeScaleAspectFit,
    scaleaspectfit: UIViewContentModeScaleAspectFit,
    scale_aspect_fit: UIViewContentModeScaleAspectFit,
    fill: UIViewContentModeScaleAspectFill,
    scaleaspectfill: UIViewContentModeScaleAspectFill,
    scale_aspect_fill: UIViewContentModeScaleAspectFill,
    redraw: UIViewContentModeRedraw,
    center: UIViewContentModeCenter,
    top: UIViewContentModeTop,
    bottom: UIViewContentModeBottom,
    left: UIViewContentModeLeft,
    right: UIViewContentModeRight,
    topleft: UIViewContentModeTopLeft,
    topright: UIViewContentModeTopRight,
    bottomleft: UIViewContentModeBottomLeft,
    bottomright: UIViewContentModeBottomRight,
  }

  @tableview_styles = {
    plain:   UITableViewStylePlain,
    grouped: UITableViewStyleGrouped,
  }

  @tableview_rowanimation = {
    fade:      UITableViewRowAnimationFade,
    right:     UITableViewRowAnimationRight,
    left:      UITableViewRowAnimationLeft,
    top:       UITableViewRowAnimationTop,
    bottom:    UITableViewRowAnimationBottom,
    none:      UITableViewRowAnimationNone,
    middle:    UITableViewRowAnimationMiddle,
    automatic: UITableViewRowAnimationAutomatic,
  }

  @tableview_cellstyles = {
    default:  UITableViewCellStyleDefault,
    value1:   UITableViewCellStyleValue1,
    value2:   UITableViewCellStyleValue2,
    subtitle: UITableViewCellStyleSubtitle,
  }

  @tableview_cellaccessorytype = {
    none:                   UITableViewCellAccessoryNone,
    disclosure:             UITableViewCellAccessoryDisclosureIndicator,
    disclosureindicator:    UITableViewCellAccessoryDisclosureIndicator,
    detail:                 UITableViewCellAccessoryDetailDisclosureButton,
    detaildisclosurebutton: UITableViewCellAccessoryDetailDisclosureButton,
    checkmark:              UITableViewCellAccessoryCheckmark,
  }

  @tableview_cellselectionstyle = {
    none: UITableViewCellSelectionStyleNone,
    blue: UITableViewCellSelectionStyleBlue,
    gray: UITableViewCellSelectionStyleGray,
  }

  @tableview_cellseparatorstyle = {
    none: UITableViewCellSeparatorStyleNone,
    singleline: UITableViewCellSeparatorStyleSingleLine,
    single: UITableViewCellSeparatorStyleSingleLine,
    singlelineetched: UITableViewCellSeparatorStyleSingleLineEtched,
    etched: UITableViewCellSeparatorStyleSingleLineEtched,
  }

  @statusbar_styles = {
    default:     UIStatusBarStyleDefault,
    black:       UIStatusBarStyleBlackOpaque,
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
    ascii:                 UIKeyboardTypeASCIICapable,
    numbersandpunctuation: UIKeyboardTypeNumbersAndPunctuation,
    url:                   UIKeyboardTypeURL,
    numberpad:             UIKeyboardTypeNumberPad,
    number:                UIKeyboardTypeNumberPad,
    phonepad:              UIKeyboardTypePhonePad,
    phone:                 UIKeyboardTypePhonePad,
    namephonepad:          UIKeyboardTypeNamePhonePad,
    nameandphone:          UIKeyboardTypeNamePhonePad,
    emailaddress:          UIKeyboardTypeEmailAddress,
    email:                 UIKeyboardTypeEmailAddress,
  }

  @autoresizemasks = {
    none: UIViewAutoresizingNone,

    flexibleleft:   UIViewAutoresizingFlexibleLeftMargin,
    flexiblewidth:  UIViewAutoresizingFlexibleWidth,
    flexibleright:  UIViewAutoresizingFlexibleRightMargin,
    flexibletop:    UIViewAutoresizingFlexibleTopMargin,
    flexibleheight: UIViewAutoresizingFlexibleHeight,
    flexiblebottom: UIViewAutoresizingFlexibleBottomMargin,

    # aliases
    left:   UIViewAutoresizingFlexibleLeftMargin,
    width:  UIViewAutoresizingFlexibleWidth,
    right:  UIViewAutoresizingFlexibleRightMargin,
    top:    UIViewAutoresizingFlexibleTopMargin,
    height: UIViewAutoresizingFlexibleHeight,
    bottom: UIViewAutoresizingFlexibleBottomMargin,
  }

  @image_sourcetypes = {
    camera:  UIImagePickerControllerSourceTypeCamera,
    library: UIImagePickerControllerSourceTypePhotoLibrary,
    album:   UIImagePickerControllerSourceTypeSavedPhotosAlbum,
  }
  @image_capturemode = {
    photo: UIImagePickerControllerCameraCaptureModePhoto,
    video: UIImagePickerControllerCameraCaptureModeVideo,
  }
  @image_cameradevice = {
    front: UIImagePickerControllerCameraDeviceFront,
    rear:  UIImagePickerControllerCameraDeviceRear,
  }
  @image_quality = {
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

  @ca_timingfunctions = {
    linear:            KCAMediaTimingFunctionLinear,
    easein:            KCAMediaTimingFunctionEaseIn,
    ease_in:           KCAMediaTimingFunctionEaseIn,
    easeout:           KCAMediaTimingFunctionEaseOut,
    ease_out:          KCAMediaTimingFunctionEaseOut,
    easeinout:         KCAMediaTimingFunctionEaseInEaseOut,
    ease_in_out:       KCAMediaTimingFunctionEaseInEaseOut,
    ease_in_ease_out:  KCAMediaTimingFunctionEaseInEaseOut,
    default:           KCAMediaTimingFunctionDefault,
  }

  @cg_linecapstyles = {
    butt: KCGLineCapButt,
    round: KCGLineCapRound,
    square: KCGLineCapSquare,
  }

  @cg_linejoinstyles = {
    miter: KCGLineJoinMiter,
    round: KCGLineJoinRound,
    bevel: KCGLineJoinBevel,
  }

  @gesture_recognizer_states = {
    possible:   UIGestureRecognizerStatePossible,
    began:      UIGestureRecognizerStateBegan,
    changed:    UIGestureRecognizerStateChanged,
    ended:      UIGestureRecognizerStateEnded,
    cancelled:  UIGestureRecognizerStateCancelled,
    failed:     UIGestureRecognizerStateFailed,
    recognized: UIGestureRecognizerStateRecognized,
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

  def uideviceorientation
    look_in(Symbol.device_orientations)
  end

  def uiinterfaceorientation
    look_in(Symbol.interface_orientations)
  end

  def uiinterfacemask
    look_in(Symbol.interface_masks)
  end

  def uitextalignment
    look_in(Symbol.textalignments)
  end
  alias uialignment uitextalignment


  def uilinebreakmode
    look_in(Symbol.linebreakmodes)
  end

  def uibaselineadjustment
    look_in(Symbol.baselineadjustments)
  end
  alias uibaseline uibaselineadjustment


  def uiinterfaceorientation
    look_in(Symbol.orientations)
  end
  alias uiorientation uiinterfaceorientation

  def uibuttontype
    look_in(Symbol.buttontypes)
  end

  def uibordertype
    look_in(Symbol.border_types)
  end
  alias uiborderstyle uibordertype

  def uicontrolstate
    look_in(Symbol.control_states)
  end
  alias uistate uicontrolstate


  def uicontrolevent
    look_in(Symbol.control_events)
  end

  def uireturnkey
    look_in(Symbol.returnkeys)
  end

  def uiactivityindicatorstyle
    look_in(Symbol.activityindicator_styles)
  end
  alias uiactivityindicatorviewstyle uiactivityindicatorstyle


  def uisegmentedstyle
    look_in(Symbol.segmented_styles)
  end
  alias uisegmentedcontrolstyle uisegmentedstyle


  def uidatepickermode
    look_in(Symbol.datepicker_modes)
  end

  def uicontentmode
    look_in(Symbol.content_modes)
  end
  alias uiviewcontentmode uicontentmode

  def uitablestyle
    look_in(Symbol.tableview_styles)
  end
  alias uitableviewstyle uitablestyle

  def uitablerowanimation
    look_in(Symbol.tableview_rowanimation)
  end
  alias uitableviewrowanimation uitablerowanimation

  def uitablecellstyle
    look_in(Symbol.tableview_cellstyles)
  end
  alias uitableviewcellstyle uitablecellstyle

  def uitablecellaccessory
    look_in(Symbol.tableview_cellaccessorytype)
  end
  alias uitableviewcellaccessorytype uitablecellaccessory

  def uitablecellselectionstyle
    look_in(Symbol.tableview_cellselectionstyle)
  end
  alias uitableviewcellselectionstyle uitablecellselectionstyle

  def uitablecellseparatorstyle
    look_in(Symbol.tableview_cellseparatorstyle)
  end

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

  def uiautoresizemask
    look_in(Symbol.autoresizemasks)
  end
  alias uiviewautoresizing uiautoresizemask
  alias uiautoresizingmask uiautoresizemask
  alias uiautoresize uiautoresizemask

  def uiimagesource
    look_in(Symbol.image_sourcetypes)
  end
  alias uiimagesourcetype uiimagesource

  def uiimagecapture
    look_in(Symbol.image_capturemode)
  end
  alias uiimagecapturemode uiimagecapture

  def uiimagecamera
    look_in(Symbol.image_cameradevice)
  end
  alias uiimagecameradevice uiimagecamera
  alias uiimagedevice uiimagecamera

  def uiimagequality
    look_in(Symbol.image_quality)
  end
  alias uiimagequalitytype uiimagequality

  def catimingfunction
    look_in(Symbol.ca_timingfunctions)
  end
  alias catiming catimingfunction

  def cglinecap
    look_in(Symbol.cg_linecapstyles)
  end
  alias cglinecapstyle cglinecap

  def cglinejoin
    look_in(Symbol.cg_linejoinstyles)
  end
  alias cglinejoinstyle cglinejoin

  def uigesturerecognizerstate
    look_in(Symbol.gesture_recognizer_states)
  end
  alias uigesturestate uigesturerecognizerstate

  def uifont(size=UIFont.systemFontSize)
    # system fonts
    if Symbol.system_fonts.has_key? self
      font = look_in(Symbol.system_fonts)
      if size.is_a? Symbol
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
    if size.is_a? Symbol
      return UIFont.send(Symbol.font_sizes[self])
    end
    return size.to_f
  end

  def nsdatestyle
    look_in(Symbol.date_styles)
  end
  alias nsdateformatterstyle nsdatestyle

  def nsnumberstyle
    look_in(Symbol.number_styles)
  end
  alias nsnumberformatterstyle nsnumberstyle

end
