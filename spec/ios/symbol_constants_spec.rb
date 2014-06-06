describe "Symbol - constants" do

  describe "should work" do

    it 'should support `uidevice`' do
      :iphone.uidevice.should == UIUserInterfaceIdiomPhone
      :ipad.uidevice.should == UIUserInterfaceIdiomPad
    end

    it 'should support `uideviceorientation`' do
      :unknown.uideviceorientation.should == UIDeviceOrientationUnknown
      :portrait.uideviceorientation.should == UIDeviceOrientationPortrait
      :upside_down.uideviceorientation.should == UIDeviceOrientationPortraitUpsideDown
      :left.uideviceorientation.should == UIDeviceOrientationLandscapeLeft
      :right.uideviceorientation.should == UIDeviceOrientationLandscapeRight
      :face_up.uideviceorientation.should == UIDeviceOrientationFaceUp
      :face_down.uideviceorientation.should == UIDeviceOrientationFaceDown
    end

    it 'should support `uiinterfaceorientation`' do
      :portrait.uiinterfaceorientation.should == UIInterfaceOrientationPortrait
      :upside_down.uiinterfaceorientation.should == UIInterfaceOrientationPortraitUpsideDown
      :left.uiinterfaceorientation.should == UIInterfaceOrientationLandscapeLeft
      :right.uiinterfaceorientation.should == UIInterfaceOrientationLandscapeRight
    end

    it 'should support `uiinterfacemask`' do
      :portrait.uiinterfacemask.should == UIInterfaceOrientationMaskPortrait
      :landscrape.uiinterfacemask.should == UIInterfaceOrientationMaskLandscape
      :left.uiinterfacemask.should == UIInterfaceOrientationMaskLandscapeLeft
      :right.uiinterfacemask.should == UIInterfaceOrientationMaskLandscapeRight
      :upside_down.uiinterfacemask.should == UIInterfaceOrientationMaskPortraitUpsideDown
      :all_but_upside_down.uiinterfacemask.should == UIInterfaceOrientationMaskAllButUpsideDown
      :iphone.uiinterfacemask.should == UIInterfaceOrientationMaskAllButUpsideDown
      :all.uiinterfacemask.should == UIInterfaceOrientationMaskAll
      :ipad.uiinterfacemask.should == UIInterfaceOrientationMaskAll
    end

    it 'should support `uiautoresizemask`' do
      :none.uiautoresizemask.should == UIViewAutoresizingNone
      :flexible_left.uiautoresizemask.should == UIViewAutoresizingFlexibleLeftMargin
      :flexible_width.uiautoresizemask.should == UIViewAutoresizingFlexibleWidth
      :flexible_right.uiautoresizemask.should == UIViewAutoresizingFlexibleRightMargin
      :flexible_top.uiautoresizemask.should == UIViewAutoresizingFlexibleTopMargin
      :flexible_height.uiautoresizemask.should == UIViewAutoresizingFlexibleHeight
      :flexible_bottom.uiautoresizemask.should == UIViewAutoresizingFlexibleBottomMargin
      :fill.uiautoresizemask.should == UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
      :fill_top.uiautoresizemask.should == UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin
      :fill_bottom.uiautoresizemask.should == UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin
      :fill_left.uiautoresizemask.should == UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin
      :fill_right.uiautoresizemask.should == UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin
      :fixed_top_left.uiautoresizemask.should == UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin
      :fixed_top_middle.uiautoresizemask.should == UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin
      :fixed_top_right.uiautoresizemask.should == UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin
      :fixed_middle_left.uiautoresizemask.should == UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin
      :fixed_middle.uiautoresizemask.should == UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
      :fixed_middle_right.uiautoresizemask.should == UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin
      :fixed_bottom_left.uiautoresizemask.should == UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin
      :fixed_bottom_middle.uiautoresizemask.should == UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin
      :fixed_bottom_right.uiautoresizemask.should == UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin
      :float_horizontal.uiautoresizemask.should == UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
      :float_vertical.uiautoresizemask.should == UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
    end

    it 'should support `uireturnkey`' do
      :default.uireturnkey.should == UIReturnKeyDefault
      :return.uireturnkey.should == UIReturnKeyDefault
      :go.uireturnkey.should == UIReturnKeyGo
      :google.uireturnkey.should == UIReturnKeyGoogle
      :join.uireturnkey.should == UIReturnKeyJoin
      :next.uireturnkey.should == UIReturnKeyNext
      :route.uireturnkey.should == UIReturnKeyRoute
      :search.uireturnkey.should == UIReturnKeySearch
      :send.uireturnkey.should == UIReturnKeySend
      :yahoo.uireturnkey.should == UIReturnKeyYahoo
      :done.uireturnkey.should == UIReturnKeyDone
      :emergency_call.uireturnkey.should == UIReturnKeyEmergencyCall
    end

    it 'should support `uikeyboardtype`' do
      :default.uikeyboardtype.should == UIKeyboardTypeDefault
      :ascii_capable.uikeyboardtype.should == UIKeyboardTypeASCIICapable
      :ascii.uikeyboardtype.should == UIKeyboardTypeASCIICapable
      :numbers_and_punctuation.uikeyboardtype.should == UIKeyboardTypeNumbersAndPunctuation
      :url.uikeyboardtype.should == UIKeyboardTypeURL
      :number_pad.uikeyboardtype.should == UIKeyboardTypeNumberPad
      :number.uikeyboardtype.should == UIKeyboardTypeNumberPad
      :phone_pad.uikeyboardtype.should == UIKeyboardTypePhonePad
      :phone.uikeyboardtype.should == UIKeyboardTypePhonePad
      :name_phone_pad.uikeyboardtype.should == UIKeyboardTypeNamePhonePad
      :name_and_phone.uikeyboardtype.should == UIKeyboardTypeNamePhonePad
      :email_address.uikeyboardtype.should == UIKeyboardTypeEmailAddress
      :email.uikeyboardtype.should == UIKeyboardTypeEmailAddress
    end

    it 'should support `nstextalignment`' do
      :left.nstextalignment.should == NSTextAlignmentLeft
      :right.nstextalignment.should == NSTextAlignmentRight
      :center.nstextalignment.should == NSTextAlignmentCenter
    end

    it 'should support `uilinebreakmode`' do
      :word_wrap.uilinebreakmode.should == UILineBreakModeWordWrap
      :character_wrap.uilinebreakmode.should == UILineBreakModeCharacterWrap
      :clip.uilinebreakmode.should == UILineBreakModeClip
      :head_truncation.uilinebreakmode.should == UILineBreakModeHeadTruncation
      :tail_truncation.uilinebreakmode.should == UILineBreakModeTailTruncation
      :middle_truncation.uilinebreakmode.should == UILineBreakModeMiddleTruncation
    end

    it 'should support `uibaselineadjustment`' do
      :align_baselines.uibaselineadjustment.should == UIBaselineAdjustmentAlignBaselines
      :align_centers.uibaselineadjustment.should == UIBaselineAdjustmentAlignCenters
      :none.uibaselineadjustment.should == UIBaselineAdjustmentNone
    end

    it 'should support `uibordertype`' do
      :none.uibordertype.should == UITextBorderStyleNone
      :line.uibordertype.should == UITextBorderStyleLine
      :bezel.uibordertype.should == UITextBorderStyleBezel
      :rounded.uibordertype.should == UITextBorderStyleRoundedRect
      :rounded_rect.uibordertype.should == UITextBorderStyleRoundedRect
    end

    it 'should support `nsdatestyle`' do
      :no.nsdatestyle.should == NSDateFormatterNoStyle
      :none.nsdatestyle.should == NSDateFormatterNoStyle
      :short.nsdatestyle.should == NSDateFormatterShortStyle
      :medium.nsdatestyle.should == NSDateFormatterMediumStyle
      :long.nsdatestyle.should == NSDateFormatterLongStyle
      :full.nsdatestyle.should == NSDateFormatterFullStyle
    end

    it 'should support `nsnumberstyle`' do
      :no.nsnumberstyle.should == NSNumberFormatterNoStyle
      :none.nsnumberstyle.should == NSNumberFormatterNoStyle
      :decimal.nsnumberstyle.should == NSNumberFormatterDecimalStyle
      :currency.nsnumberstyle.should == NSNumberFormatterCurrencyStyle
      :percent.nsnumberstyle.should == NSNumberFormatterPercentStyle
      :scientific.nsnumberstyle.should == NSNumberFormatterScientificStyle
      :spell_out.nsnumberstyle.should == NSNumberFormatterSpellOutStyle
    end

    it 'should support `uifontsize`' do
      :label.uifontsize.should == UIFont.labelFontSize
      :button.uifontsize.should == UIFont.buttonFontSize
      :small.uifontsize.should == UIFont.smallSystemFontSize
      :system.uifontsize.should == UIFont.systemFontSize
    end

    it 'should support `uistatusbarstyle`' do
      :default.uistatusbarstyle.should == UIStatusBarStyleDefault
      :black.uistatusbarstyle.should == UIStatusBarStyleBlackOpaque
      :translucent.uistatusbarstyle.should == UIStatusBarStyleBlackTranslucent
    end

    it 'should support `uibarmetrics`' do
      :default.uibarmetrics.should == UIBarMetricsDefault
      :landscape.uibarmetrics.should == UIBarMetricsLandscapePhone
    end

    it 'should support `uibarbuttonitem`' do
      :done.uibarbuttonitem.should == UIBarButtonSystemItemDone
      :cancel.uibarbuttonitem.should == UIBarButtonSystemItemCancel
      :edit.uibarbuttonitem.should == UIBarButtonSystemItemEdit
      :save.uibarbuttonitem.should == UIBarButtonSystemItemSave
      :add.uibarbuttonitem.should == UIBarButtonSystemItemAdd
      :flexible_space.uibarbuttonitem.should == UIBarButtonSystemItemFlexibleSpace
      :fixed_space.uibarbuttonitem.should == UIBarButtonSystemItemFixedSpace
      :compose.uibarbuttonitem.should == UIBarButtonSystemItemCompose
      :reply.uibarbuttonitem.should == UIBarButtonSystemItemReply
      :action.uibarbuttonitem.should == UIBarButtonSystemItemAction
      :organize.uibarbuttonitem.should == UIBarButtonSystemItemOrganize
      :bookmarks.uibarbuttonitem.should == UIBarButtonSystemItemBookmarks
      :search.uibarbuttonitem.should == UIBarButtonSystemItemSearch
      :refresh.uibarbuttonitem.should == UIBarButtonSystemItemRefresh
      :stop.uibarbuttonitem.should == UIBarButtonSystemItemStop
      :camera.uibarbuttonitem.should == UIBarButtonSystemItemCamera
      :trash.uibarbuttonitem.should == UIBarButtonSystemItemTrash
      :play.uibarbuttonitem.should == UIBarButtonSystemItemPlay
      :pause.uibarbuttonitem.should == UIBarButtonSystemItemPause
      :rewind.uibarbuttonitem.should == UIBarButtonSystemItemRewind
      :fast_forward.uibarbuttonitem.should == UIBarButtonSystemItemFastForward
      :undo.uibarbuttonitem.should == UIBarButtonSystemItemUndo
      :redo.uibarbuttonitem.should == UIBarButtonSystemItemRedo
      :page_curl.uibarbuttonitem.should == UIBarButtonSystemItemPageCurl
    end

    it 'should support `uibarbuttonstyle`' do
      :plain.uibarbuttonstyle.should == UIBarButtonItemStylePlain
      :bordered.uibarbuttonstyle.should == UIBarButtonItemStyleBordered
      :done.uibarbuttonstyle.should == UIBarButtonItemStyleDone
    end

    it 'should support `uitabbarsystemitem`' do
      :more.uitabbarsystemitem.should == UITabBarSystemItemMore
      :favorites.uitabbarsystemitem.should == UITabBarSystemItemFavorites
      :featured.uitabbarsystemitem.should == UITabBarSystemItemFeatured
      :top_rated.uitabbarsystemitem.should == UITabBarSystemItemTopRated
      :recents.uitabbarsystemitem.should == UITabBarSystemItemRecents
      :contacts.uitabbarsystemitem.should == UITabBarSystemItemContacts
      :history.uitabbarsystemitem.should == UITabBarSystemItemHistory
      :bookmarks.uitabbarsystemitem.should == UITabBarSystemItemBookmarks
      :search.uitabbarsystemitem.should == UITabBarSystemItemSearch
      :downloads.uitabbarsystemitem.should == UITabBarSystemItemDownloads
      :most_recent.uitabbarsystemitem.should == UITabBarSystemItemMostRecent
      :most_viewed.uitabbarsystemitem.should == UITabBarSystemItemMostViewed
    end

    it 'should support `uibuttontype`' do
      :custom.uibuttontype.should == UIButtonTypeCustom
      :rounded.uibuttontype.should == UIButtonTypeRoundedRect
      :rounded_rect.uibuttontype.should == UIButtonTypeRoundedRect
      :detail.uibuttontype.should == UIButtonTypeDetailDisclosure
      :detail_disclosure.uibuttontype.should == UIButtonTypeDetailDisclosure
      :info.uibuttontype.should == UIButtonTypeInfoLight
      :info_light.uibuttontype.should == UIButtonTypeInfoLight
      :info_dark.uibuttontype.should == UIButtonTypeInfoDark
      :contact.uibuttontype.should == UIButtonTypeContactAdd
      :contact_add.uibuttontype.should == UIButtonTypeContactAdd
      :system.uibuttontype.should == UIButtonTypeSystem
    end

    it 'should support `uicontrolstate`' do
      :normal.uicontrolstate.should == UIControlStateNormal
      :highlighted.uicontrolstate.should == UIControlStateHighlighted
      :disabled.uicontrolstate.should == UIControlStateDisabled
      :selected.uicontrolstate.should == UIControlStateSelected
      :application.uicontrolstate.should == UIControlStateApplication
    end

    it 'should support `uicontrolevent`' do
      :touch.uicontrolevent.should == UIControlEventTouchUpInside
      :touch_up.uicontrolevent.should == UIControlEventTouchUpInside
      :touch_down.uicontrolevent.should == UIControlEventTouchDown
      :touch_start.uicontrolevent.should == UIControlEventTouchDown | UIControlEventTouchDragEnter
      :touch_stop.uicontrolevent.should == UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchDragExit
      :change.uicontrolevent.should == UIControlEventValueChanged | UIControlEventEditingChanged
      :begin.uicontrolevent.should == UIControlEventEditingDidBegin
      :end.uicontrolevent.should == UIControlEventEditingDidEnd

      :touch_down_repeat.uicontrolevent.should == UIControlEventTouchDownRepeat
      :touch_drag_inside.uicontrolevent.should == UIControlEventTouchDragInside
      :touch_drag_outside.uicontrolevent.should == UIControlEventTouchDragOutside
      :touch_drag_enter.uicontrolevent.should == UIControlEventTouchDragEnter
      :touch_drag_exit.uicontrolevent.should == UIControlEventTouchDragExit
      :touch_up_inside.uicontrolevent.should == UIControlEventTouchUpInside
      :touch_up_outside.uicontrolevent.should == UIControlEventTouchUpOutside
      :touch_cancel.uicontrolevent.should == UIControlEventTouchCancel

      :value_changed.uicontrolevent.should == UIControlEventValueChanged

      :editing_did_begin.uicontrolevent.should == UIControlEventEditingDidBegin
      :editing_changed.uicontrolevent.should == UIControlEventEditingChanged
      :editing_did_change.uicontrolevent.should == UIControlEventEditingChanged
      :editing_did_end.uicontrolevent.should == UIControlEventEditingDidEnd
      :editing_did_end_on_exit.uicontrolevent.should == UIControlEventEditingDidEndOnExit

      :all_touch.uicontrolevent.should == UIControlEventAllTouchEvents
      :all_editing.uicontrolevent.should == UIControlEventAllEditingEvents
      :application.uicontrolevent.should == UIControlEventApplicationReserved
      :system.uicontrolevent.should == UIControlEventSystemReserved
      :all.uicontrolevent.should == UIControlEventAllEvents
    end

    it 'should support `uiactivityindicatorstyle`' do
      :large.uiactivityindicatorstyle.should == UIActivityIndicatorViewStyleWhiteLarge
      :white_large.uiactivityindicatorstyle.should == UIActivityIndicatorViewStyleWhiteLarge
      :white.uiactivityindicatorstyle.should == UIActivityIndicatorViewStyleWhite
      :gray.uiactivityindicatorstyle.should == UIActivityIndicatorViewStyleGray
    end

    it 'should support `uisegmentedstyle`' do
      :plain.uisegmentedstyle.should == UISegmentedControlStylePlain
      :bordered.uisegmentedstyle.should == UISegmentedControlStyleBordered
      :bar.uisegmentedstyle.should == UISegmentedControlStyleBar
      :bezeled.uisegmentedstyle.should == UISegmentedControlStyleBezeled
    end

    it 'should support `uidatepickermode`' do
      :time.uidatepickermode.should == UIDatePickerModeTime
      :date.uidatepickermode.should == UIDatePickerModeDate
      :date_and_time.uidatepickermode.should == UIDatePickerModeDateAndTime
      :count_down_timer.uidatepickermode.should == UIDatePickerModeCountDownTimer
    end

    it 'should support `uicontentmode`' do
      :scale.uicontentmode.should == UIViewContentModeScaleToFill
      :scale_to_fill.uicontentmode.should == UIViewContentModeScaleToFill
      :fit.uicontentmode.should == UIViewContentModeScaleAspectFit
      :scale_aspect_fit.uicontentmode.should == UIViewContentModeScaleAspectFit
      :fill.uicontentmode.should == UIViewContentModeScaleAspectFill
      :scale_aspect_fill.uicontentmode.should == UIViewContentModeScaleAspectFill
      :redraw.uicontentmode.should == UIViewContentModeRedraw
      :center.uicontentmode.should == UIViewContentModeCenter
      :top.uicontentmode.should == UIViewContentModeTop
      :bottom.uicontentmode.should == UIViewContentModeBottom
      :left.uicontentmode.should == UIViewContentModeLeft
      :right.uicontentmode.should == UIViewContentModeRight
      :top_left.uicontentmode.should == UIViewContentModeTopLeft
      :top_right.uicontentmode.should == UIViewContentModeTopRight
      :bottom_left.uicontentmode.should == UIViewContentModeBottomLeft
      :bottom_right.uicontentmode.should == UIViewContentModeBottomRight
    end

    it 'should support `uianimationcurve`' do
      :ease_in_out.uianimationcurve.should == UIViewAnimationCurveEaseInOut
      :ease_in.uianimationcurve.should == UIViewAnimationCurveEaseIn
      :ease_out.uianimationcurve.should == UIViewAnimationCurveEaseOut
      :linear.uianimationcurve.should == UIViewAnimationCurveLinear
    end

    it 'should support `uianimationoption`' do
      :layout_subviews.uianimationoption.should == UIViewAnimationOptionLayoutSubviews
      :allow_user_interaction.uianimationoption.should == UIViewAnimationOptionAllowUserInteraction
      :begin_from_current_state.uianimationoption.should == UIViewAnimationOptionBeginFromCurrentState
      :repeat.uianimationoption.should == UIViewAnimationOptionRepeat
      :autoreverse.uianimationoption.should == UIViewAnimationOptionAutoreverse
      :override_inherited_duration.uianimationoption.should == UIViewAnimationOptionOverrideInheritedDuration
      :override_inherited_curve.uianimationoption.should == UIViewAnimationOptionOverrideInheritedCurve
      :allow_animated_content.uianimationoption.should == UIViewAnimationOptionAllowAnimatedContent
      :show_hide_transition_views.uianimationoption.should == UIViewAnimationOptionShowHideTransitionViews
      :override_inherited_options.uianimationoption.should == UIViewAnimationOptionOverrideInheritedOptions
      :curve_ease_in_out.uianimationoption.should == UIViewAnimationOptionCurveEaseInOut
      :ease_in_out.uianimationoption.should == UIViewAnimationOptionCurveEaseInOut
      :curve_ease_in.uianimationoption.should == UIViewAnimationOptionCurveEaseIn
      :ease_in.uianimationoption.should == UIViewAnimationOptionCurveEaseIn
      :curve_ease_out.uianimationoption.should == UIViewAnimationOptionCurveEaseOut
      :ease_out.uianimationoption.should == UIViewAnimationOptionCurveEaseOut
      :curve_linear.uianimationoption.should == UIViewAnimationOptionCurveLinear
      :linear.uianimationoption.should == UIViewAnimationOptionCurveLinear
      :transition_none.uianimationoption.should == UIViewAnimationOptionTransitionNone
      :transition_flip_from_left.uianimationoption.should == UIViewAnimationOptionTransitionFlipFromLeft
      :transition_flip_from_right.uianimationoption.should == UIViewAnimationOptionTransitionFlipFromRight
      :transition_curl_up.uianimationoption.should == UIViewAnimationOptionTransitionCurlUp
      :transition_curl_down.uianimationoption.should == UIViewAnimationOptionTransitionCurlDown
      :transition_cross_dissolve.uianimationoption.should == UIViewAnimationOptionTransitionCrossDissolve
      :transition_flip_from_top.uianimationoption.should == UIViewAnimationOptionTransitionFlipFromTop
      :transition_flip_from_bottom.uianimationoption.should == UIViewAnimationOptionTransitionFlipFromBottom
    end

    it 'should support `uitablestyle`' do
      :plain.uitablestyle.should == UITableViewStylePlain
      :grouped.uitablestyle.should == UITableViewStyleGrouped
    end

    it 'should support `uitablerowanimation`' do
      :fade.uitablerowanimation.should == UITableViewRowAnimationFade
      :right.uitablerowanimation.should == UITableViewRowAnimationRight
      :left.uitablerowanimation.should == UITableViewRowAnimationLeft
      :top.uitablerowanimation.should == UITableViewRowAnimationTop
      :bottom.uitablerowanimation.should == UITableViewRowAnimationBottom
      :none.uitablerowanimation.should == UITableViewRowAnimationNone
      :middle.uitablerowanimation.should == UITableViewRowAnimationMiddle
      :automatic.uitablerowanimation.should == UITableViewRowAnimationAutomatic
    end

    it 'should support `uitablecellstyle`' do
      :default.uitablecellstyle.should == UITableViewCellStyleDefault
      :value1.uitablecellstyle.should == UITableViewCellStyleValue1
      :value2.uitablecellstyle.should == UITableViewCellStyleValue2
      :subtitle.uitablecellstyle.should == UITableViewCellStyleSubtitle
    end

    it 'should support `uitablecellaccessorytype`' do
      :none.uitablecellaccessorytype.should == UITableViewCellAccessoryNone
      :disclosure.uitablecellaccessorytype.should == UITableViewCellAccessoryDisclosureIndicator
      :disclosure_indicator.uitablecellaccessorytype.should == UITableViewCellAccessoryDisclosureIndicator
      :detail.uitablecellaccessorytype.should == UITableViewCellAccessoryDetailDisclosureButton
      :detail_disclosure_button.uitablecellaccessorytype.should == UITableViewCellAccessoryDetailDisclosureButton
      :checkmark.uitablecellaccessorytype.should == UITableViewCellAccessoryCheckmark
    end

    it 'should support `uitablecellselectionstyle`' do
      :none.uitablecellselectionstyle.should == UITableViewCellSelectionStyleNone
      :blue.uitablecellselectionstyle.should == UITableViewCellSelectionStyleBlue
      :gray.uitablecellselectionstyle.should == UITableViewCellSelectionStyleGray
    end

    it 'should support `uitablecellseparatorstyle`' do
      :none.uitablecellseparatorstyle.should == UITableViewCellSeparatorStyleNone
      :single_line.uitablecellseparatorstyle.should == UITableViewCellSeparatorStyleSingleLine
      :single.uitablecellseparatorstyle.should == UITableViewCellSeparatorStyleSingleLine
      :single_line_etched.uitablecellseparatorstyle.should == UITableViewCellSeparatorStyleSingleLineEtched
      :etched.uitablecellseparatorstyle.should == UITableViewCellSeparatorStyleSingleLineEtched
    end

    it 'should support `uialertstyle`' do
      :default.uialertstyle.should == UIAlertViewStyleDefault
      :secure_text_input.uialertstyle.should == UIAlertViewStyleSecureTextInput
      :plain_text_input.uialertstyle.should == UIAlertViewStylePlainTextInput
      :login_and_password_input.uialertstyle.should == UIAlertViewStyleLoginAndPasswordInput
    end

    it 'should support `uiactionstyle`' do
      :automatic.uiactionstyle.should == UIActionSheetStyleAutomatic
      :default.uiactionstyle.should == UIActionSheetStyleDefault
      :black_translucent.uiactionstyle.should == UIActionSheetStyleBlackTranslucent
      :black_opaque.uiactionstyle.should == UIActionSheetStyleBlackOpaque
    end

    it 'should support `uiimagesource`' do
      :camera.uiimagesource.should == UIImagePickerControllerSourceTypeCamera
      :library.uiimagesource.should == UIImagePickerControllerSourceTypePhotoLibrary
      :album.uiimagesource.should == UIImagePickerControllerSourceTypeSavedPhotosAlbum
    end

    it 'should support `uiimagecapture`' do
      :photo.uiimagecapture.should == UIImagePickerControllerCameraCaptureModePhoto
      :video.uiimagecapture.should == UIImagePickerControllerCameraCaptureModeVideo
    end

    it 'should support `uiimagecamera`' do
      :front.uiimagecamera.should == UIImagePickerControllerCameraDeviceFront
      :rear.uiimagecamera.should == UIImagePickerControllerCameraDeviceRear
    end

    it 'should support `uiimagequality`' do
      :high.uiimagequality.should == UIImagePickerControllerQualityTypeHigh
      :medium.uiimagequality.should == UIImagePickerControllerQualityTypeMedium
      :low.uiimagequality.should == UIImagePickerControllerQualityTypeLow
      :vga.uiimagequality.should == UIImagePickerControllerQualityType640x480
      :i1280x720.uiimagequality.should == UIImagePickerControllerQualityTypeIFrame1280x720
      :i1280.uiimagequality.should == UIImagePickerControllerQualityTypeIFrame1280x720
      :i720.uiimagequality.should == UIImagePickerControllerQualityTypeIFrame1280x720
      :i960x540.uiimagequality.should == UIImagePickerControllerQualityTypeIFrame960x540
      :i960.uiimagequality.should == UIImagePickerControllerQualityTypeIFrame960x540
      :i540.uiimagequality.should == UIImagePickerControllerQualityTypeIFrame960x540
    end

    it 'should support `catimingfunction`' do
      :linear.catimingfunction.should == KCAMediaTimingFunctionLinear
      :ease_in.catimingfunction.should == KCAMediaTimingFunctionEaseIn
      :ease_out.catimingfunction.should == KCAMediaTimingFunctionEaseOut
      :ease_in_out.catimingfunction.should == KCAMediaTimingFunctionEaseInEaseOut
      :ease_in_ease_out.catimingfunction.should == KCAMediaTimingFunctionEaseInEaseOut
      :default.catimingfunction.should == KCAMediaTimingFunctionDefault
    end

    it 'should support `cglinecap`' do
      :butt.cglinecap.should == KCGLineCapButt
      :round.cglinecap.should == KCGLineCapRound
      :square.cglinecap.should == KCGLineCapSquare
    end

    it 'should support `cglinejoin`' do
      :miter.cglinejoin.should == KCGLineJoinMiter
      :round.cglinejoin.should == KCGLineJoinRound
      :bevel.cglinejoin.should == KCGLineJoinBevel
    end

    it 'should support `uigesturerecognizerstate`' do
      :possible.uigesturerecognizerstate.should == UIGestureRecognizerStatePossible
      :began.uigesturerecognizerstate.should == UIGestureRecognizerStateBegan
      :changed.uigesturerecognizerstate.should == UIGestureRecognizerStateChanged
      :ended.uigesturerecognizerstate.should == UIGestureRecognizerStateEnded
      :cancelled.uigesturerecognizerstate.should == UIGestureRecognizerStateCancelled
      :failed.uigesturerecognizerstate.should == UIGestureRecognizerStateFailed
      :recognized.uigesturerecognizerstate.should == UIGestureRecognizerStateRecognized
    end

  end

  describe "Symbol deprecated methods" do

    before do
      SugarCube::Legacy.log? true
    end

    after do
      SugarCube::Legacy.log? false
    end

    it 'should support `uiautoresizemask`' do
      :full.uiautoresizemask.should == :fill.uiautoresizemask
      :fixed_top.uiautoresizemask.should == :fill_top.uiautoresizemask
      :fixed_bottom.uiautoresizemask.should == :fill_bottom.uiautoresizemask
      :fixed_left.uiautoresizemask.should == :fill_left.uiautoresizemask
      :fixed_right.uiautoresizemask.should == :fill_right.uiautoresizemask
      SugarCube::Legacy.log.length.should > 0
    end

    it 'should support `uitextalignment`' do
      :left.uialignment.should == :left.uitextalignment
    end

    it 'should support `uibaselineadjustment`' do
      :alignbaselines.uibaselineadjustment.should == UIBaselineAdjustmentAlignBaselines
      :aligncenters.uibaselineadjustment.should == UIBaselineAdjustmentAlignCenters
    end

    it 'should have alias for `uibaselineadjustment`' do
      :alignbaselines.uibaseline.should == :alignbaselines.uibaselineadjustment
    end

    it 'should support `uireturnkey`' do
      :emergencycall.uireturnkey.should == :emergency_call.uireturnkey
      SugarCube::Legacy.log.length.should > 0
    end

    it 'should support `uikeyboardtype`' do
      :asciicapable.uikeyboardtype.should == :ascii_capable.uikeyboardtype
      :numbersandpunctuation.uikeyboardtype.should == :numbers_and_punctuation.uikeyboardtype
      :numberpad.uikeyboardtype.should == :number_pad.uikeyboardtype
      :phonepad.uikeyboardtype.should == :phone_pad.uikeyboardtype
      :namephonepad.uikeyboardtype.should == :name_phone_pad.uikeyboardtype
      :nameandphone.uikeyboardtype.should == :name_and_phone.uikeyboardtype
      :emailaddress.uikeyboardtype.should == :email_address.uikeyboardtype
      SugarCube::Legacy.log.length.should > 0
    end

    it 'should support `uilinebreakmode`' do
      :wordwrap.uilinebreakmode.should == :word_wrap.uilinebreakmode
      :characterwrap.uilinebreakmode.should == :character_wrap.uilinebreakmode
      :headtruncation.uilinebreakmode.should == :head_truncation.uilinebreakmode
      :tailtruncation.uilinebreakmode.should == :tail_truncation.uilinebreakmode
      :middletruncation.uilinebreakmode.should == :middle_truncation.uilinebreakmode
      SugarCube::Legacy.log.length.should > 0
    end

    it 'should support `nsnumberstyle`' do
      :spellout.nsnumberstyle.should == :spell_out.nsnumberstyle
      SugarCube::Legacy.log.length.should > 0
    end

    it 'should support `uibarbuttonitem`' do
      :flexiblespace.uibarbuttonitem.should == :flexible_space.uibarbuttonitem
      :fixedspace.uibarbuttonitem.should == :fixed_space.uibarbuttonitem
      :fastforward.uibarbuttonitem.should == :fast_forward.uibarbuttonitem
      SugarCube::Legacy.log.length.should > 0
    end

    it 'should support `uicontrolevent`' do
      :changed.uicontrolevent.should == :change.uicontrolevent
      SugarCube::Legacy.log.length.should > 0
    end

    it 'should support `uiactivityindicatorstyle`' do
      :whitelarge.uiactivityindicatorstyle.should == :white_large.uiactivityindicatorstyle
      SugarCube::Legacy.log.length.should > 0
    end

    it 'should support `uidatepickermode`' do
      :dateandtime.uidatepickermode.should == :date_and_time.uidatepickermode
      :countdowntimer.uidatepickermode.should == :count_down_timer.uidatepickermode
      SugarCube::Legacy.log.length.should > 0
    end

    it 'should support `uicontentmode`' do
      :scaletofill.uicontentmode.should == :scale_to_fill.uicontentmode
      :scaleaspectfit.uicontentmode.should == :scale_aspect_fit.uicontentmode
      :scaleaspectfill.uicontentmode.should == :scale_aspect_fill.uicontentmode
      :topleft.uicontentmode.should == :top_left.uicontentmode
      :topright.uicontentmode.should == :top_right.uicontentmode
      :bottomleft.uicontentmode.should == :bottom_left.uicontentmode
      :bottomright.uicontentmode.should == :bottom_right.uicontentmode
      SugarCube::Legacy.log.length.should > 0
    end

    it 'should support `uitablecellaccessorytype`' do
      :disclosureindicator.uitablecellaccessorytype.should == :disclosure_indicator.uitablecellaccessorytype
      :detaildisclosurebutton.uitablecellaccessorytype.should == :detail_disclosure_button.uitablecellaccessorytype
      SugarCube::Legacy.log.length.should > 0
    end

    it 'should support `uitablecellseparatorstyle`' do
      :singleline.uitablecellseparatorstyle.should == :single_line.uitablecellseparatorstyle
      :singlelineetched.uitablecellseparatorstyle.should == :single_line_etched.uitablecellseparatorstyle
      SugarCube::Legacy.log.length.should > 0
    end

    it 'should support `catimingfunction`' do
      :easein.catimingfunction.should == :ease_in.catimingfunction
      :easeout.catimingfunction.should == :ease_out.catimingfunction
      :easeinout.catimingfunction.should == :ease_in_out.catimingfunction
      SugarCube::Legacy.log.length.should > 0
    end

  end

  describe "Aliases" do
    it 'should have alias for `uiinterfaceorientation`' do
      :portrait.uiorientation.should == :portrait.uiinterfaceorientation
    end

    it 'should have alias for `uiautoresizemask`' do
      :none.uiviewautoresizing.should == :none.uiautoresizemask
      :none.uiautoresizingmask.should == :none.uiautoresizemask
      :none.uiautoresize.should == :none.uiautoresizemask
    end

    it 'should support `uibaselineadjustment`' do
      :align_baselines.uibaselineadjustment.should == UIBaselineAdjustmentAlignBaselines
      :align_centers.uibaselineadjustment.should == UIBaselineAdjustmentAlignCenters
    end

    it 'should have alias for `uibaselineadjustment`' do
      :align_baselines.uibaseline.should == :align_baselines.uibaselineadjustment
    end

    it 'should have alias for `uibordertype`' do
      :none.uiborderstyle.should == :none.uibordertype
    end

    it 'should have alias for `nsdatestyle`' do
      :no.nsdateformatterstyle.should == :no.nsdatestyle
    end

    it 'should have alias for `nsnumberstyle`' do
      :no.nsnumberformatterstyle.should == :no.nsnumberstyle
    end

    it 'should have alias for `uicontrolstate`' do
      :normal.uistate.should == :normal.uicontrolstate
    end

    it 'should have alias for `uiactivityindicatorstyle`' do
      :large.uiactivityindicatorviewstyle.should == :large.uiactivityindicatorstyle
    end

    it 'should have alias for `uisegmentedstyle`' do
      :plain.uisegmentedcontrolstyle.should == :plain.uisegmentedstyle
    end

    it 'should have alias for `uicontentmode`' do
      :scale.uiviewcontentmode.should == :scale.uicontentmode
    end

    it 'should have alias for `uianimationcurve`' do
      :ease_in_out.uiviewanimationcurve.should == :ease_in_out.uianimationcurve
    end

    it 'should have alias for `uitablestyle`' do
      :plain.uitableviewstyle.should == :plain.uitablestyle
    end

    it 'should have alias for `uitablerowanimation`' do
      :fade.uitableviewrowanimation.should == :fade.uitablerowanimation
    end

    it 'should have alias for `uitablecellstyle`' do
      :default.uitableviewcellstyle.should == :default.uitablecellstyle
    end

    it 'should have alias for `uitablecellaccessorytype`' do
      :none.uitablecellaccessory.should == :none.uitablecellaccessorytype
      :none.uitableviewcellaccessorytype.should == :none.uitablecellaccessorytype
    end

    it 'should have alias for `uitablecellselectionstyle`' do
      :none.uitableviewcellselectionstyle.should == :none.uitablecellselectionstyle
    end

    it 'should have alias for `uialertstyle`' do
      :default.uialertviewstyle.should == :default.uialertstyle
    end

    it 'should have alias for `uiactionstyle`' do
      :automatic.uiactionsheetstyle.should == :automatic.uiactionstyle
    end

    it 'should have alias for `uiimagesource`' do
      :camera.uiimagesourcetype.should == :camera.uiimagesource
    end

    it 'should have alias for `uiimagecapture`' do
      :photo.uiimagecapturemode.should == :photo.uiimagecapture
    end

    it 'should have alias for `uiimagecamera`' do
      :front.uiimagecameradevice.should == :front.uiimagecamera
      :front.uiimagedevice.should == :front.uiimagecamera
    end

    it 'should have alias for `uiimagequality`' do
      :high.uiimagequalitytype.should == :high.uiimagequality
    end

    it 'should have alias for `catimingfunction`' do
      :linear.catiming.should == :linear.catimingfunction
    end

    it 'should have alias for `cglinecap`' do
      :butt.cglinecapstyle.should == :butt.cglinecap
    end

    it 'should have alias for `cglinejoin`' do
      :miter.cglinejoinstyle.should == :miter.cglinejoin
    end

    it 'should have alias for `uigesturerecognizerstate`' do
      :possible.uigesturestate.should == :possible.uigesturerecognizerstate
    end

  end

  describe "not found" do
    it 'should not find nonexistant `uidevice`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uidevice }
    end

    it 'should not find nonexistant `uideviceorientation`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uideviceorientation }
    end

    it 'should not find nonexistant `uiinterfaceorientation`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uiinterfaceorientation }
    end

    it 'should not find nonexistant `uiinterfacemask`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uiinterfacemask }
    end

    it 'should not find nonexistant `uiautoresizemask`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uiautoresizemask }
    end

    it 'should not find nonexistant `uireturnkey`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uireturnkey }
    end

    it 'should not find nonexistant `uikeyboardtype`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uikeyboardtype }
    end

    it 'should not find nonexistant `nstextalignment`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.nstextalignment }
    end

    it 'should not find nonexistant `uilinebreakmode`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uilinebreakmode }
    end

    it 'should not find nonexistant `uibaselineadjustment`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uibaselineadjustment }
    end

    it 'should not find nonexistant `uibordertype`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uibordertype }
    end

    it 'should not find nonexistant `nsdatestyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.nsdatestyle }
    end

    it 'should not find nonexistant `nsnumberstyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.nsnumberstyle }
    end

    it 'should not find nonexistant `uifontsize`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uifontsize }
    end

    it 'should not find nonexistant `uistatusbarstyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uistatusbarstyle }
    end

    it 'should not find nonexistant `uibarmetrics`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uibarmetrics }
    end

    it 'should not find nonexistant `uibarbuttonitem`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uibarbuttonitem }
    end

    it 'should not find nonexistant `uibarbuttonstyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uibarbuttonstyle }
    end

    it 'should not find nonexistant `uibuttontype`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uibuttontype }
    end

    it 'should not find nonexistant `uicontrolstate`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uicontrolstate }
    end

    it 'should not find nonexistant `uicontrolevent`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uicontrolevent }
    end

    it 'should not find nonexistant `uiactivityindicatorstyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uiactivityindicatorstyle }
    end

    it 'should not find nonexistant `uisegmentedstyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uisegmentedstyle }
    end

    it 'should not find nonexistant `uidatepickermode`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uidatepickermode }
    end

    it 'should not find nonexistant `uicontentmode`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uicontentmode }
    end

    it 'should not find nonexistant `uianimationcurve`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uianimationcurve }
    end

    it 'should not find nonexistant `uitablestyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uitablestyle }
    end

    it 'should not find nonexistant `uitablerowanimation`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uitablerowanimation }
    end

    it 'should not find nonexistant `uitablecellstyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uitablecellstyle }
    end

    it 'should not find nonexistant `uitablecellaccessorytype`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uitablecellaccessorytype }
    end

    it 'should not find nonexistant `uitablecellselectionstyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uitablecellselectionstyle }
    end

    it 'should not find nonexistant `uitablecellseparatorstyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uitablecellseparatorstyle }
    end

    it 'should not find nonexistant `uialertstyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uialertstyle }
    end

    it 'should not find nonexistant `uiactionstyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uiactionstyle }
    end

    it 'should not find nonexistant `uiimagesource`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uiimagesource }
    end

    it 'should not find nonexistant `uiimagecapture`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uiimagecapture }
    end

    it 'should not find nonexistant `uiimagecamera`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uiimagecamera }
    end

    it 'should not find nonexistant `uiimagequality`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uiimagequality }
    end

    it 'should not find nonexistant `catimingfunction`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.catimingfunction }
    end

    it 'should not find nonexistant `cglinecap`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.cglinecap }
    end

    it 'should not find nonexistant `cglinejoin`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.cglinejoin }
    end

    it 'should not find nonexistant `uigesturerecognizerstate`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.uigesturerecognizerstate }
    end

  end

end
