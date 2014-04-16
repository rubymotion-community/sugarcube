# Deprecated names for symbol constants.
class << Symbol

  def devices
    SugarCube::Legacy.log("Symbol.devices[] is deprecated. Use Symbol.uidevice[] instead.")
    uidevice
  end

  def device_orientations
    SugarCube::Legacy.log("Symbol.device_orientations[] is deprecated. Use Symbol.uideviceorientation[] instead.")
    uideviceorientation
  end

  def interface_orientations
    SugarCube::Legacy.log("Symbol.interface_orientations[] is deprecated. Use Symbol.uiinterfaceorientation[] instead.")
    uiinterfaceorientation
  end

  def interface_masks
    SugarCube::Legacy.log("Symbol.interface_masks[] is deprecated. Use Symbol.uiinterfacemask[] instead.")
    uiinterfacemask
  end

  def autoresizemasks
    SugarCube::Legacy.log("Symbol.autoresizemasks[] is deprecated. Use Symbol.uiautoresizemask[] instead.")
    uiautoresizemask
  end

  def returnkeys
    SugarCube::Legacy.log("Symbol.returnkeys[] is deprecated. Use Symbol.uireturnkey[] instead.")
    uireturnkey
  end

  def keyboardtypes
    SugarCube::Legacy.log("Symbol.keyboardtypes[] is deprecated. Use Symbol.uikeyboardtype[] instead.")
    uikeyboardtype
  end

  def textalignments
    SugarCube::Legacy.log("Symbol.textalignments[] is deprecated. Use Symbol.nstextalignment[] instead.")
    nstextalignment
  end

  def linebreakmodes
    SugarCube::Legacy.log("Symbol.linebreakmodes[] is deprecated. Use Symbol.uilinebreakmode[] instead.")
    uilinebreakmode
  end

  def baselineadjustments
    SugarCube::Legacy.log("Symbol.baselineadjustments[] is deprecated. Use Symbol.uibaselineadjustment[] instead.")
    uibaselineadjustment
  end

  def border_types
    SugarCube::Legacy.log("Symbol.border_types[] is deprecated. Use Symbol.uibordertype[] instead.")
    uibordertype
  end

  def date_styles
    SugarCube::Legacy.log("Symbol.date_styles[] is deprecated. Use Symbol.nsdatestyle[] instead.")
    nsdatestyle
  end

  def number_styles
    SugarCube::Legacy.log("Symbol.number_styles[] is deprecated. Use Symbol.nsnumberstyle[] instead.")
    nsnumberstyle
  end

  def system_fonts
    SugarCube::Legacy.log("Symbol.system_fonts[] is deprecated. Use Symbol.uifont[] instead.")
    uifont
  end

  def font_sizes
    SugarCube::Legacy.log("Symbol.font_sizes[] is deprecated. Use Symbol.uifontsize[] instead.")
    uifontsize
  end

  def statusbar_styles
    SugarCube::Legacy.log("Symbol.statusbar_styles[] is deprecated. Use Symbol.uistatusbarstyle[] instead.")
    uistatusbarstyle
  end

  def barmetrics
    SugarCube::Legacy.log("Symbol.barmetrics[] is deprecated. Use Symbol.uibarmetrics[] instead.")
    uibarmetrics
  end

  def barbuttonitems
    SugarCube::Legacy.log("Symbol.barbuttonitems[] is deprecated. Use Symbol.uibarbuttonitem[] instead.")
    uibarbuttonitem
  end

  def barbuttonstyles
    SugarCube::Legacy.log("Symbol.barbuttonstyles[] is deprecated. Use Symbol.uibarbuttonstyle[] instead.")
    uibarbuttonstyle
  end

  def buttontypes
    SugarCube::Legacy.log("Symbol.buttontypes[] is deprecated. Use Symbol.uibuttontype[] instead.")
    uibuttontype
  end

  def control_states
    SugarCube::Legacy.log("Symbol.control_states[] is deprecated. Use Symbol.uicontrolstate[] instead.")
    uicontrolstate
  end

  def control_events
    SugarCube::Legacy.log("Symbol.control_events[] is deprecated. Use Symbol.uicontrolevent[] instead.")
    uicontrolevent
  end

  def activityindicator_styles
    SugarCube::Legacy.log("Symbol.activityindicator_styles[] is deprecated. Use Symbol.uiactivityindicatorstyle[] instead.")
    uiactivityindicatorstyle
  end

  def segmented_styles
    SugarCube::Legacy.log("Symbol.segmented_styles[] is deprecated. Use Symbol.uisegmentedstyle[] instead.")
    uisegmentedstyle
  end

  def datepicker_modes
    SugarCube::Legacy.log("Symbol.datepicker_modes[] is deprecated. Use Symbol.uidatepickermode[] instead.")
    uidatepickermode
  end

  def uiview_content_modes
    SugarCube::Legacy.log("Symbol.uiview_content_modes[] is deprecated. Use Symbol.uicontentmode[] instead.")
    uicontentmode
  end

  def uiview_animation_curve
    SugarCube::Legacy.log("Symbol.uiview_animation_curve[] is deprecated. Use Symbol.uianimationcurve[] instead.")
    uianimationcurve
  end

  def tableview_styles
    SugarCube::Legacy.log("Symbol.tableview_styles[] is deprecated. Use Symbol.uitablestyle[] instead.")
    uitablestyle
  end

  def tableview_rowanimation
    SugarCube::Legacy.log("Symbol.tableview_rowanimation[] is deprecated. Use Symbol.uitablerowanimation[] instead.")
    uitablerowanimation
  end

  def tableview_cellstyles
    SugarCube::Legacy.log("Symbol.tableview_cellstyles[] is deprecated. Use Symbol.uitablecellstyle[] instead.")
    uitablecellstyle
  end

  def tableview_cellaccessorytype
    SugarCube::Legacy.log("Symbol.tableview_cellaccessorytype[] is deprecated. Use Symbol.uitablecellaccessorytype[] instead.")
    uitablecellaccessorytype
  end

  def tableview_cellselectionstyle
    SugarCube::Legacy.log("Symbol.tableview_cellselectionstyle[] is deprecated. Use Symbol.uitablecellselectionstyle[] instead.")
    uitablecellselectionstyle
  end

  def tableview_cellseparatorstyle
    SugarCube::Legacy.log("Symbol.tableview_cellseparatorstyle[] is deprecated. Use Symbol.uitablecellseparatorstyle[] instead.")
    uitablecellseparatorstyle
  end

  def alert_view_styles
    SugarCube::Legacy.log("Symbol.alert_view_styles[] is deprecated. Use Symbol.uialertstyle[] instead.")
    uialertstyle
  end

  def action_sheet_styles
    SugarCube::Legacy.log("Symbol.action_sheet_styles[] is deprecated. Use Symbol.uiactionstyle[] instead.")
    uiactionstyle
  end

  def image_sourcetypes
    SugarCube::Legacy.log("Symbol.image_sourcetypes[] is deprecated. Use Symbol.uiimagesource[] instead.")
    uiimagesource
  end

  def image_capturemode
    SugarCube::Legacy.log("Symbol.image_capturemode[] is deprecated. Use Symbol.uiimagecapture[] instead.")
    uiimagecapture
  end

  def image_cameradevice
    SugarCube::Legacy.log("Symbol.image_cameradevice[] is deprecated. Use Symbol.uiimagecamera[] instead.")
    uiimagecamera
  end

  def image_quality
    SugarCube::Legacy.log("Symbol.image_quality[] is deprecated. Use Symbol.uiimagequality[] instead.")
    uiimagequality
  end

  def ca_timingfunctions
    SugarCube::Legacy.log("Symbol.ca_timingfunctions[] is deprecated. Use Symbol.catimingfunction[] instead.")
    catimingfunction
  end

  def cg_linecapstyles
    SugarCube::Legacy.log("Symbol.cg_linecapstyles[] is deprecated. Use Symbol.cglinecap[] instead.")
    cglinecap
  end

  def cg_linejoinstyles
    SugarCube::Legacy.log("Symbol.cg_linejoinstyles[] is deprecated. Use Symbol.cglinejoin[] instead.")
    cglinejoin
  end

  def gesture_recognizer_states
    SugarCube::Legacy.log("Symbol.gesture_recognizer_states[] is deprecated. Use Symbol.uigesturerecognizerstate[] instead.")
    uigesturerecognizerstate
  end

end
