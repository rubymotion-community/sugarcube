describe "Legacy code" do

  before do
    SugarCube::Legacy.log? true
  end

  after do
    SugarCube::Legacy.log? false
  end

  it 'should have Symbol methods' do
    should.not.raise {
      Symbol.devices.should == Symbol.uidevice
      Symbol.device_orientations.should == Symbol.uideviceorientation
      Symbol.interface_orientations.should == Symbol.uiinterfaceorientation
      Symbol.interface_masks.should == Symbol.uiinterfacemask
      Symbol.autoresizemasks.should == Symbol.uiautoresizemask
      Symbol.returnkeys.should == Symbol.uireturnkey
      Symbol.keyboardtypes.should == Symbol.uikeyboardtype
      Symbol.textalignments.should == Symbol.uitextalignment
      Symbol.linebreakmodes.should == Symbol.uilinebreakmode
      Symbol.baselineadjustments.should == Symbol.uibaselineadjustment
      Symbol.border_types.should == Symbol.uibordertype
      Symbol.date_styles.should == Symbol.nsdatestyle
      Symbol.number_styles.should == Symbol.nsnumberstyle
      Symbol.system_fonts.should == Symbol.uifont
      Symbol.font_sizes.should == Symbol.uifontsize
      Symbol.statusbar_styles.should == Symbol.uistatusbarstyle
      Symbol.barmetrics.should == Symbol.uibarmetrics
      Symbol.barbuttonitems.should == Symbol.uibarbuttonitem
      Symbol.barbuttonstyles.should == Symbol.uibarbuttonstyle
      Symbol.buttontypes.should == Symbol.uibuttontype
      Symbol.control_states.should == Symbol.uicontrolstate
      Symbol.control_events.should == Symbol.uicontrolevent
      Symbol.activityindicator_styles.should == Symbol.uiactivityindicatorstyle
      Symbol.segmented_styles.should == Symbol.uisegmentedstyle
      Symbol.datepicker_modes.should == Symbol.uidatepickermode
      Symbol.uiview_content_modes.should == Symbol.uicontentmode
      Symbol.uiview_animation_curve.should == Symbol.uianimationcurve
      Symbol.tableview_styles.should == Symbol.uitablestyle
      Symbol.tableview_rowanimation.should == Symbol.uitablerowanimation
      Symbol.tableview_cellstyles.should == Symbol.uitablecellstyle
      Symbol.tableview_cellaccessorytype.should == Symbol.uitablecellaccessorytype
      Symbol.tableview_cellselectionstyle.should == Symbol.uitablecellselectionstyle
      Symbol.tableview_cellseparatorstyle.should == Symbol.uitablecellseparatorstyle
      Symbol.alert_view_styles.should == Symbol.uialertstyle
      Symbol.action_sheet_styles.should == Symbol.uiactionstyle
      Symbol.image_sourcetypes.should == Symbol.uiimagesource
      Symbol.image_capturemode.should == Symbol.uiimagecapture
      Symbol.image_cameradevice.should == Symbol.uiimagecamera
      Symbol.image_quality.should == Symbol.uiimagequality
      Symbol.ca_timingfunctions.should == Symbol.catimingfunction
      Symbol.cg_linecapstyles.should == Symbol.cglinecap
      Symbol.cg_linejoinstyles.should == Symbol.cglinejoin
      Symbol.gesture_recognizer_states.should == Symbol.uigesturerecognizerstate
      SugarCube::Legacy.log.length.should > 0
    }
  end
end
