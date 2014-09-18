=begin
Adds constant lookups to the Symbol class.  These methods are prefixed with `ui`
or `ns` to make their intent clear, and to provide a little bit of "namespacing"

    # alignment
    :left.nsalignment => NSTextAlignmentLeft

    # uicolors
    :black.uicolor => UIColor.blackColor

You can extend the defaults by adding entries:

    Symbol.css_colors[:my_color] = 0x123456

    :my_color.uicolor => UIColor
=end
class Symbol

  def uidevice
    SugarCube.look_in(self, Symbol.uidevice)
  end

  def uideviceorientation
    SugarCube.look_in(self, Symbol.uideviceorientation)
  end

  def uiinterfaceorientation
    SugarCube.look_in(self, Symbol.uiinterfaceorientation)
  end
  alias uiorientation uiinterfaceorientation

  def uiinterfacemask
    SugarCube.look_in(self, Symbol.uiinterfacemask)
  end

  def uiautoresizemask
    SugarCube.look_in(self, Symbol.uiautoresizemask, Symbol.uiautoresizemask__deprecated)
  end
  alias uiviewautoresizing uiautoresizemask
  alias uiautoresizingmask uiautoresizemask
  alias uiautoresize uiautoresizemask

  def uireturnkey
    SugarCube.look_in(self, Symbol.uireturnkey, Symbol.uireturnkey__deprecated)
  end

  def uikeyboardtype
    SugarCube.look_in(self, Symbol.uikeyboardtype, Symbol.uikeyboardtype__deprecated)
  end

  def uitextalignment
    SugarCube.log('uitextalignment is deprecated.  Use nstextalignment instead.')
    SugarCube.look_in(self, Symbol.nstextalignment)
  end
  alias uialignment uitextalignment

  def nstextalignment
    SugarCube.look_in(self, Symbol.nstextalignment)
  end
  alias nsalignment nstextalignment

  def uilinebreakmode
    SugarCube.log('uilinebreakmode is deprecated.  Use nslinebreakmode instead.')
    SugarCube.look_in(self, Symbol.nslinebreakmode)
  end

  def nslinebreakmode
    SugarCube.look_in(self, Symbol.nslinebreakmode)
  end
  alias nslinebreak nslinebreakmode

  def uibaselineadjustment
    SugarCube.look_in(self, Symbol.uibaselineadjustment, Symbol.uibaselineadjustment__deprecated)
  end
  alias uibaseline uibaselineadjustment

  def uibordertype
    SugarCube.look_in(self, Symbol.uibordertype)
  end
  alias uiborderstyle uibordertype

  def nsdatestyle
    SugarCube.look_in(self, Symbol.nsdatestyle)
  end
  alias nsdateformatterstyle nsdatestyle

  def nsnumberstyle
    SugarCube.look_in(self, Symbol.nsnumberstyle, Symbol.nsnumberstyle__deprecated)
  end
  alias nsnumberformatterstyle nsnumberstyle

  def uistatusbarstyle
    SugarCube.look_in(self, Symbol.uistatusbarstyle)
  end

  def uibarmetrics
    SugarCube.look_in(self, Symbol.uibarmetrics)
  end

  def uibarbuttonitem
    SugarCube.look_in(self, Symbol.uibarbuttonitem, Symbol.uibarbuttonitem__deprecated)
  end

  def uibarbuttonstyle
    SugarCube.look_in(self, Symbol.uibarbuttonstyle)
  end

  def uitabbarsystemitem
    SugarCube.look_in(self, Symbol.uitabbarsystemitem)
  end
  alias uitabbaritem uitabbarsystemitem

  def uibuttontype
    SugarCube.look_in(self, Symbol.uibuttontype)
  end

  def uicontrolstate
    SugarCube.look_in(self, Symbol.uicontrolstate)
  end
  alias uistate uicontrolstate


  def uicontrolevent
    SugarCube.look_in(self, Symbol.uicontrolevent, Symbol.uicontrolevent__deprecated)
  end

  def uiactivityindicatorstyle
    SugarCube.look_in(self, Symbol.uiactivityindicatorstyle, Symbol.uiactivityindicatorstyle__deprecated)
  end
  alias uiactivityindicatorviewstyle uiactivityindicatorstyle

  def uisegmentedstyle
    SugarCube.look_in(self, Symbol.uisegmentedstyle)
  end
  alias uisegmentedcontrolstyle uisegmentedstyle

  def uidatepickermode
    SugarCube.look_in(self, Symbol.uidatepickermode, Symbol.uidatepickermode__deprecated)
  end

  def uicontentmode
    SugarCube.look_in(self, Symbol.uicontentmode, Symbol.uicontentmode__deprecated)
  end
  alias uiviewcontentmode uicontentmode

  def uianimationcurve
    SugarCube.look_in(self, Symbol.uianimationcurve)
  end
  alias uiviewanimationcurve uianimationcurve

  def uianimationoption
    SugarCube.look_in(self, Symbol.uianimationoption)
  end
  alias uiviewanimationoption uianimationoption

  def uitablestyle
    SugarCube.look_in(self, Symbol.uitablestyle)
  end
  alias uitableviewstyle uitablestyle

  def uitablerowanimation
    SugarCube.look_in(self, Symbol.uitablerowanimation)
  end
  alias uitableviewrowanimation uitablerowanimation

  def uitablecellstyle
    SugarCube.look_in(self, Symbol.uitablecellstyle)
  end
  alias uitableviewcellstyle uitablecellstyle

  def uitablecellaccessorytype
    SugarCube.look_in(self, Symbol.uitablecellaccessorytype, Symbol.uitablecellaccessorytype__deprecated)
  end
  alias uitablecellaccessory uitablecellaccessorytype
  alias uitableviewcellaccessorytype uitablecellaccessorytype

  def uitablecellselectionstyle
    SugarCube.look_in(self, Symbol.uitablecellselectionstyle)
  end
  alias uitableviewcellselectionstyle uitablecellselectionstyle

  def uitablecellseparatorstyle
    SugarCube.look_in(self, Symbol.uitablecellseparatorstyle, Symbol.uitablecellseparatorstyle__deprecated)
  end

  def uialertstyle
    SugarCube.look_in(self, Symbol.uialertstyle)
  end
  alias uialertviewstyle uialertstyle

  def uiactionstyle
    SugarCube.look_in(self, Symbol.uiactionstyle)
  end
  alias uiactionsheetstyle uiactionstyle

  def uialertcontrollerstyle
    SugarCube.look_in(self, Symbol.uialertcontrollerstyle)
  end

  def uialertactionstyle
    SugarCube.look_in(self, Symbol.uialertactionstyle)
  end

  def uiimagesource
    SugarCube.look_in(self, Symbol.uiimagesource)
  end
  alias uiimagesourcetype uiimagesource

  def uiimagecapture
    SugarCube.look_in(self, Symbol.uiimagecapture)
  end
  alias uiimagecapturemode uiimagecapture

  def uiimagecamera
    SugarCube.look_in(self, Symbol.uiimagecamera)
  end
  alias uiimagecameradevice uiimagecamera
  alias uiimagedevice uiimagecamera

  def uiimagequality
    SugarCube.look_in(self, Symbol.uiimagequality)
  end
  alias uiimagequalitytype uiimagequality

  def catimingfunction
    SugarCube.look_in(self, Symbol.catimingfunction, Symbol.catimingfunction__deprecated)
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

  def uigesturerecognizerstate
    SugarCube.look_in(self, Symbol.uigesturerecognizerstate)
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
    attr :nstextalignment
    attr :nslinebreakmode
    attr :uibaselineadjustment__deprecated
    attr :uibaselineadjustment
    attr :uibordertype
    attr :nsdatestyle
    attr :nsnumberstyle
    attr :nsnumberstyle__deprecated

    attr :uistatusbarstyle
    attr :uibarmetrics
    attr :uibarbuttonitem
    attr :uibarbuttonitem__deprecated
    attr :uibarbuttonstyle
    attr :uitabbarsystemitem

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
    attr :uianimationoption

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

    attr :uialertcontrollerstyle
    attr :uialertactionstyle

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

  @nstextalignment = {
    left:   NSTextAlignmentLeft,
    right:  NSTextAlignmentRight,
    center: NSTextAlignmentCenter,
  }

  @nslinebreakmode = {
    word_wrapping:     NSLineBreakByWordWrapping,
    word_wrap:         NSLineBreakByWordWrapping,
    word:              NSLineBreakByWordWrapping,
    char_wrapping:     NSLineBreakByCharWrapping,
    char_wrap:         NSLineBreakByCharWrapping,
    character_wrap:    NSLineBreakByCharWrapping,
    char:              NSLineBreakByCharWrapping,
    clipping:          NSLineBreakByClipping,
    clip:              NSLineBreakByClipping,
    truncating_head:   NSLineBreakByTruncatingHead,
    head_truncation:   NSLineBreakByTruncatingHead,
    head:              NSLineBreakByTruncatingHead,
    truncating_tail:   NSLineBreakByTruncatingTail,
    tail_truncation:   NSLineBreakByTruncatingTail,
    tail:              NSLineBreakByTruncatingTail,
    truncating_middle: NSLineBreakByTruncatingMiddle,
    middle_truncation: NSLineBreakByTruncatingMiddle,
    middle:            NSLineBreakByTruncatingMiddle
  }

  @uibaselineadjustment__deprecated = {
    alignbaselines: :align_baselines,
    aligncenters:   :align_centers,
  }
  @uibaselineadjustment = {
    align_baselines: UIBaselineAdjustmentAlignBaselines,
    align_centers:   UIBaselineAdjustmentAlignCenters,
    none:            UIBaselineAdjustmentNone,
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
    pagecurl:      :page_curl,
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
    page_curl:      UIBarButtonSystemItemPageCurl,
  }

  @uibarbuttonstyle = {
    plain:    UIBarButtonItemStylePlain,
    bordered: UIBarButtonItemStyleBordered,
    done:     UIBarButtonItemStyleDone
  }

  @uitabbarsystemitem = {
    more:        UITabBarSystemItemMore,
    favorites:   UITabBarSystemItemFavorites,
    featured:    UITabBarSystemItemFeatured,
    top_rated:   UITabBarSystemItemTopRated,
    recents:     UITabBarSystemItemRecents,
    contacts:    UITabBarSystemItemContacts,
    history:     UITabBarSystemItemHistory,
    bookmarks:   UITabBarSystemItemBookmarks,
    search:      UITabBarSystemItemSearch,
    downloads:   UITabBarSystemItemDownloads,
    most_recent: UITabBarSystemItemMostRecent,
    most_viewed: UITabBarSystemItemMostViewed,
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
  if defined?(UIButtonTypeSystem)
    @uibuttontype[:system] = UIButtonTypeSystem
  end

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

  @uianimationoption = {
    layout_subviews:             UIViewAnimationOptionLayoutSubviews,
    allow_user_interaction:      UIViewAnimationOptionAllowUserInteraction,
    begin_from_current_state:    UIViewAnimationOptionBeginFromCurrentState,
    repeat:                      UIViewAnimationOptionRepeat,
    autoreverse:                 UIViewAnimationOptionAutoreverse,
    override_inherited_duration: UIViewAnimationOptionOverrideInheritedDuration,
    override_inherited_curve:    UIViewAnimationOptionOverrideInheritedCurve,
    allow_animated_content:      UIViewAnimationOptionAllowAnimatedContent,
    show_hide_transition_views:  UIViewAnimationOptionShowHideTransitionViews,
    override_inherited_options:  UIViewAnimationOptionOverrideInheritedOptions,
    curve_ease_in_out:           UIViewAnimationOptionCurveEaseInOut,
    ease_in_out:                 UIViewAnimationOptionCurveEaseInOut,
    curve_ease_in:               UIViewAnimationOptionCurveEaseIn,
    ease_in:                     UIViewAnimationOptionCurveEaseIn,
    curve_ease_out:              UIViewAnimationOptionCurveEaseOut,
    ease_out:                    UIViewAnimationOptionCurveEaseOut,
    curve_linear:                UIViewAnimationOptionCurveLinear,
    linear:                      UIViewAnimationOptionCurveLinear,
    transition_none:             UIViewAnimationOptionTransitionNone,
    transition_flip_from_left:   UIViewAnimationOptionTransitionFlipFromLeft,
    transition_flip_from_right:  UIViewAnimationOptionTransitionFlipFromRight,
    transition_curl_up:          UIViewAnimationOptionTransitionCurlUp,
    transition_curl_down:        UIViewAnimationOptionTransitionCurlDown,
    transition_cross_dissolve:   UIViewAnimationOptionTransitionCrossDissolve,
    transition_flip_from_top:    UIViewAnimationOptionTransitionFlipFromTop,
    transition_flip_from_bottom: UIViewAnimationOptionTransitionFlipFromBottom,
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

  if defined?(UIAlertControllerStyleAlert)
    @uialertcontrollerstyle = {
        alert:        UIAlertControllerStyleAlert,
        action_sheet: UIAlertControllerStyleActionSheet
    }

    @uialertactionstyle = {
        default:     UIAlertActionStyleDefault,
        cancel:      UIAlertActionStyleCancel,
        destructive: UIAlertActionStyleDestructive
    }
  else
    @uialertcontrollerstyle = {}
    @uialertactionstyle = {}
  end

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

end
