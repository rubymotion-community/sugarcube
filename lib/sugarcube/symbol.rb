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
    attr :devices
    attr :device_orientations
    attr :interface_orientations
    attr :interface_masks
    attr :orientations
    attr :returnkeys
    attr :returnkeys__deprecated
    attr :statusbar_styles
    attr :barmetrics
    attr :barbuttonitems
    attr :barbuttonitems__deprecated
    attr :barbuttonstyles
    attr :keyboardtypes
    attr :keyboardtypes__deprecated
    attr :autoresizemasks
    attr :autoresizemasks__deprecated

    attr :textalignments
    attr :linebreakmodes
    attr :linebreakmodes__deprecated
    attr :baselineadjustments
    attr :system_fonts
    attr :font_sizes
    attr :date_styles
    attr :number_styles
    attr :number_styles__deprecated

    attr :buttontypes
    attr :border_types
    attr :control_states
    attr :control_events
    attr :control_events__deprecated
    attr :activityindicator_styles
    attr :activityindicator_styles__deprecated
    attr :segmented_styles
    attr :datepicker_modes
    attr :datepicker_modes__deprecated
    attr :uiview_content_modes
    attr :uiview_content_modes__deprecated
    attr :uiview_animation_curve

    attr :tableview_styles
    attr :tableview_rowanimation
    attr :tableview_cellstyles
    attr :tableview_cellaccessorytype
    attr :tableview_cellaccessorytype__deprecated
    attr :tableview_cellselectionstyle
    attr :tableview_cellseparatorstyle
    attr :tableview_cellseparatorstyle__deprecated

    attr :image_sourcetypes
    attr :image_capturemode
    attr :image_cameradevice
    attr :image_quality

    attr :ca_timingfunctions
    attr :ca_timingfunctions__deprecated

    attr :cg_linecapstyles
    attr :cg_linejoinstyles

    attr :gesture_recognizer_states
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

  @linebreakmodes__deprecated = {
    wordwrap: :word_wrap,
    characterwrap: :character_wrap,
    headtruncation: :head_truncation,
    tailtruncation: :tail_truncation,
    middletruncation: :middle_truncation,
  }
  @linebreakmodes = {
    word_wrap: UILineBreakModeWordWrap,
    character_wrap: UILineBreakModeCharacterWrap,
    clip: UILineBreakModeClip,
    head_truncation: UILineBreakModeHeadTruncation,
    tail_truncation: UILineBreakModeTailTruncation,
    middle_truncation: UILineBreakModeMiddleTruncation,
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

  @control_events__deprecated = {
    changed: :change,
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
    monospace: 'Courier New',
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

  @number_styles__deprecated = {
    spellout: :spell_out,
  }
  @number_styles = {
    no: NSNumberFormatterNoStyle,
    none: NSNumberFormatterNoStyle,
    decimal: NSNumberFormatterDecimalStyle,
    currency: NSNumberFormatterCurrencyStyle,
    percent: NSNumberFormatterPercentStyle,
    scientific: NSNumberFormatterScientificStyle,
    spell_out: NSNumberFormatterSpellOutStyle,
  }

  @returnkeys__deprecated = {
    emergencycall: :emergency_call
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
    emergency_call: UIReturnKeyEmergencyCall,
  }

  @activityindicator_styles__deprecated = {
    whitelarge: :white_large,
  }
  @activityindicator_styles = {
    large:      UIActivityIndicatorViewStyleWhiteLarge,
    white_large: UIActivityIndicatorViewStyleWhiteLarge,
    white:      UIActivityIndicatorViewStyleWhite,
    gray:       UIActivityIndicatorViewStyleGray,
  }

  @segmented_styles = {
    plain: UISegmentedControlStylePlain,
    bordered: UISegmentedControlStyleBordered,
    bar: UISegmentedControlStyleBar,
    bezeled: UISegmentedControlStyleBezeled,
  }

  @datepicker_modes__deprecated = {
    dateandtime: :date_and_time,
    countdowntimer: :count_down_timer,
  }
  @datepicker_modes = {
    time:           UIDatePickerModeTime,
    date:           UIDatePickerModeDate,
    date_and_time:    UIDatePickerModeDateAndTime,
    count_down_timer: UIDatePickerModeCountDownTimer
  }

  @uiview_content_modes__deprecated = {
    scaletofill: :scale_to_fill,
    scaleaspectfit: :scale_aspect_fit,
    scaleaspectfill: :scale_aspect_fill,
    topleft: :top_left,
    topright: :top_right,
    bottomleft: :bottom_left,
    bottomright: :bottom_right,
  }
  @uiview_content_modes = {
    scale: UIViewContentModeScaleToFill,
    scale_to_fill: UIViewContentModeScaleToFill,
    fit: UIViewContentModeScaleAspectFit,
    scale_aspect_fit: UIViewContentModeScaleAspectFit,
    fill: UIViewContentModeScaleAspectFill,
    scale_aspect_fill: UIViewContentModeScaleAspectFill,
    redraw: UIViewContentModeRedraw,
    center: UIViewContentModeCenter,
    top: UIViewContentModeTop,
    bottom: UIViewContentModeBottom,
    left: UIViewContentModeLeft,
    right: UIViewContentModeRight,
    top_left: UIViewContentModeTopLeft,
    top_right: UIViewContentModeTopRight,
    bottom_left: UIViewContentModeBottomLeft,
    bottom_right: UIViewContentModeBottomRight,
  }

  @uiview_animation_curve = {
    ease_in_out: UIViewAnimationCurveEaseInOut,
    ease_in: UIViewAnimationCurveEaseIn,
    ease_out: UIViewAnimationCurveEaseOut,
    linear: UIViewAnimationCurveLinear
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

  @tableview_cellaccessorytype__deprecated = {
    disclosureindicator: :disclosure_indicator,
    detaildisclosurebutton: :detail_disclosure_button,
  }
  @tableview_cellaccessorytype = {
    none:                   UITableViewCellAccessoryNone,
    disclosure:             UITableViewCellAccessoryDisclosureIndicator,
    disclosure_indicator:    UITableViewCellAccessoryDisclosureIndicator,
    detail:                 UITableViewCellAccessoryDetailDisclosureButton,
    detail_disclosure_button: UITableViewCellAccessoryDetailDisclosureButton,
    checkmark:              UITableViewCellAccessoryCheckmark,
  }

  @tableview_cellselectionstyle = {
    none: UITableViewCellSelectionStyleNone,
    blue: UITableViewCellSelectionStyleBlue,
    gray: UITableViewCellSelectionStyleGray,
  }

  @tableview_cellseparatorstyle__deprecated = {
    singleline: :single_line,
    singlelineetched: :single_line_etched,
  }
  @tableview_cellseparatorstyle = {
    none: UITableViewCellSeparatorStyleNone,
    single_line: UITableViewCellSeparatorStyleSingleLine,
    single: UITableViewCellSeparatorStyleSingleLine,
    single_line_etched: UITableViewCellSeparatorStyleSingleLineEtched,
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

  @barbuttonitems__deprecated = {
    flexiblespace: :flexible_space,
    fixedspace:    :fixed_space,
    fastforward:   :fast_forward,
  }
  @barbuttonitems = {
    done:          UIBarButtonSystemItemDone,
    cancel:        UIBarButtonSystemItemCancel,
    edit:          UIBarButtonSystemItemEdit,
    save:          UIBarButtonSystemItemSave,
    add:           UIBarButtonSystemItemAdd,
    flexible_space: UIBarButtonSystemItemFlexibleSpace,
    fixed_space:    UIBarButtonSystemItemFixedSpace,
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
    fast_forward:   UIBarButtonSystemItemFastForward,
    undo:          UIBarButtonSystemItemUndo,
    redo:          UIBarButtonSystemItemRedo,
    pagecurl:      UIBarButtonSystemItemPageCurl,
  }

  @barbuttonstyles = {
    plain:    UIBarButtonItemStylePlain,
    bordered: UIBarButtonItemStyleBordered,
    done:     UIBarButtonItemStyleDone
  }

  @keyboardtypes__deprecated = {
    asciicapable:          :ascii_capable,
    numbersandpunctuation: :numbers_and_punctuation,
    numberpad:             :number_pad,
    phonepad:              :phone_pad,
    namephonepad:          :name_phone_pad,
    nameandphone:          :name_and_phone,
    emailaddress:          :email_address,
  }
  @keyboardtypes = {
    default:               UIKeyboardTypeDefault,
    ascii_capable:          UIKeyboardTypeASCIICapable,
    ascii:                 UIKeyboardTypeASCIICapable,
    numbers_and_punctuation: UIKeyboardTypeNumbersAndPunctuation,
    url:                   UIKeyboardTypeURL,
    number_pad:             UIKeyboardTypeNumberPad,
    number:                UIKeyboardTypeNumberPad,
    phone_pad:              UIKeyboardTypePhonePad,
    phone:                 UIKeyboardTypePhonePad,
    name_phone_pad:          UIKeyboardTypeNamePhonePad,
    name_and_phone:          UIKeyboardTypeNamePhonePad,
    email_address:          UIKeyboardTypeEmailAddress,
    email:                 UIKeyboardTypeEmailAddress,
  }

  @autoresizemasks__deprecated = {
    full: :fill,
    fixed_top: :fill_top,
    fixed_bottom: :fill_bottom,
    fixed_left: :fill_left,
    fixed_right: :fill_right,
  }

  @autoresizemasks = {
    none: UIViewAutoresizingNone,

    flexible_left:   UIViewAutoresizingFlexibleLeftMargin,
    flexible_width:  UIViewAutoresizingFlexibleWidth,
    flexible_right:  UIViewAutoresizingFlexibleRightMargin,
    flexible_top:    UIViewAutoresizingFlexibleTopMargin,
    flexible_height: UIViewAutoresizingFlexibleHeight,
    flexible_bottom: UIViewAutoresizingFlexibleBottomMargin,

    # shorthands
    fill: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight,
    fill_top: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin,
    fill_bottom: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin,
    fill_left: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin,
    fill_right: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin,

    fixed_top_left: UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin,
    fixed_top_middle: UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin,
    fixed_top_right: UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin,
    fixed_middle_left: UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin,
    fixed_middle: UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin,
    fixed_middle_right: UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin,
    fixed_bottom_left: UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin,
    fixed_bottom_middle: UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin,
    fixed_bottom_right: UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin,

    float_horizontal: UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin,
    float_vertical: UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin,
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

  @ca_timingfunctions__deprecated = {
    easein:    :ease_in,
    easeout:   :ease_out,
    easeinout: :ease_in_out,
  }
  @ca_timingfunctions = {
    linear:            KCAMediaTimingFunctionLinear,
    ease_in:           KCAMediaTimingFunctionEaseIn,
    ease_out:          KCAMediaTimingFunctionEaseOut,
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
  def sugarcube_look_in(here, here__deprecated)
    return here[self] if here.has_key? self
    if here__deprecated[self]
      translated = here__deprecated[self]
      NSLog("The symbol #{self.inspect} has been deprecated in favor of #{translated.inspect}")
      return here[translated]
    end
    raise SugarNotFoundException.new(self.inspect)
  end

  public
  def uidevice
    sugarcube_look_in(Symbol.devices)
  end

  def uideviceorientation
    sugarcube_look_in(Symbol.device_orientations)
  end

  def uiinterfaceorientation
    sugarcube_look_in(Symbol.interface_orientations)
  end

  def uiinterfacemask
    sugarcube_look_in(Symbol.interface_masks)
  end

  def uitextalignment
    sugarcube_look_in(Symbol.textalignments)
  end
  alias uialignment uitextalignment


  def uilinebreakmode
    sugarcube_look_in(Symbol.linebreakmodes, Symbol.linebreakmodes__deprecated)
  end

  def uibaselineadjustment
    sugarcube_look_in(Symbol.baselineadjustments)
  end
  alias uibaseline uibaselineadjustment


  def uiinterfaceorientation
    sugarcube_look_in(Symbol.orientations)
  end
  alias uiorientation uiinterfaceorientation

  def uibuttontype
    sugarcube_look_in(Symbol.buttontypes)
  end

  def uibordertype
    sugarcube_look_in(Symbol.border_types)
  end
  alias uiborderstyle uibordertype

  def uicontrolstate
    sugarcube_look_in(Symbol.control_states)
  end
  alias uistate uicontrolstate


  def uicontrolevent
    sugarcube_look_in(Symbol.control_events, Symbol.control_events__deprecated)
  end

  def uireturnkey
    sugarcube_look_in(Symbol.returnkeys, Symbol.returnkeys__deprecated)
  end

  def uiactivityindicatorstyle
    sugarcube_look_in(Symbol.activityindicator_styles, Symbol.activityindicator_styles__deprecated)
  end
  alias uiactivityindicatorviewstyle uiactivityindicatorstyle


  def uisegmentedstyle
    sugarcube_look_in(Symbol.segmented_styles)
  end
  alias uisegmentedcontrolstyle uisegmentedstyle


  def uidatepickermode
    sugarcube_look_in(Symbol.datepicker_modes, Symbol.datepicker_modes__deprecated)
  end

  def uicontentmode
    sugarcube_look_in(Symbol.uiview_content_modes, Symbol.uiview_content_modes__deprecated)
  end
  alias uiviewcontentmode uicontentmode

  def uianimationcurve
    sugarcube_look_in(Symbol.uiview_animation_curve)
  end
  alias uiviewanimationcurve uianimationcurve

  def uitablestyle
    sugarcube_look_in(Symbol.tableview_styles)
  end
  alias uitableviewstyle uitablestyle

  def uitablerowanimation
    sugarcube_look_in(Symbol.tableview_rowanimation)
  end
  alias uitableviewrowanimation uitablerowanimation

  def uitablecellstyle
    sugarcube_look_in(Symbol.tableview_cellstyles)
  end
  alias uitableviewcellstyle uitablecellstyle

  def uitablecellaccessorytype
    sugarcube_look_in(Symbol.tableview_cellaccessorytype, Symbol.tableview_cellaccessorytype__deprecated)
  end
  alias uitablecellaccessory uitablecellaccessorytype
  alias uitableviewcellaccessorytype uitablecellaccessorytype

  def uitablecellselectionstyle
    sugarcube_look_in(Symbol.tableview_cellselectionstyle)
  end
  alias uitableviewcellselectionstyle uitablecellselectionstyle

  def uitablecellseparatorstyle
    sugarcube_look_in(Symbol.tableview_cellseparatorstyle, Symbol.tableview_cellseparatorstyle__deprecated)
  end

  def uistatusbarstyle
    sugarcube_look_in(Symbol.statusbar_styles)
  end

  def uibarmetrics
    sugarcube_look_in(Symbol.barmetrics)
  end

  def uibarbuttonitem
    sugarcube_look_in(Symbol.barbuttonitems, Symbol.barbuttonitems__deprecated)
  end

  def uibarbuttonstyle
    sugarcube_look_in(Symbol.barbuttonstyles)
  end

  def uikeyboardtype
    sugarcube_look_in(Symbol.keyboardtypes, Symbol.keyboardtypes__deprecated)
  end

  def uiautoresizemask
    sugarcube_look_in(Symbol.autoresizemasks, Symbol.autoresizemasks__deprecated)
  end
  alias uiviewautoresizing uiautoresizemask
  alias uiautoresizingmask uiautoresizemask
  alias uiautoresize uiautoresizemask

  def uiimagesource
    sugarcube_look_in(Symbol.image_sourcetypes)
  end
  alias uiimagesourcetype uiimagesource

  def uiimagecapture
    sugarcube_look_in(Symbol.image_capturemode)
  end
  alias uiimagecapturemode uiimagecapture

  def uiimagecamera
    sugarcube_look_in(Symbol.image_cameradevice)
  end
  alias uiimagecameradevice uiimagecamera
  alias uiimagedevice uiimagecamera

  def uiimagequality
    sugarcube_look_in(Symbol.image_quality)
  end
  alias uiimagequalitytype uiimagequality

  def catimingfunction
    sugarcube_look_in(Symbol.ca_timingfunctions, Symbol.ca_timingfunctions__deprecated)
  end
  alias catiming catimingfunction

  def cglinecap
    sugarcube_look_in(Symbol.cg_linecapstyles)
  end
  alias cglinecapstyle cglinecap

  def cglinejoin
    sugarcube_look_in(Symbol.cg_linejoinstyles)
  end
  alias cglinejoinstyle cglinejoin

  def uigesturerecognizerstate
    sugarcube_look_in(Symbol.gesture_recognizer_states)
  end
  alias uigesturestate uigesturerecognizerstate

  def uifont(size=nil)
    size ||= UIFont.systemFontSize
    # system fonts
    if Symbol.system_fonts.has_key? self
      font = sugarcube_look_in(Symbol.system_fonts)
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
    size = sugarcube_look_in(Symbol.font_sizes)
    if size.is_a?(Symbol)
      return UIFont.send(size)
    end
    return size.to_f
  end

  def nsdatestyle
    sugarcube_look_in(Symbol.date_styles)
  end
  alias nsdateformatterstyle nsdatestyle

  def nsnumberstyle
    sugarcube_look_in(Symbol.number_styles, Symbol.number_styles__deprecated)
  end
  alias nsnumberformatterstyle nsnumberstyle

end
