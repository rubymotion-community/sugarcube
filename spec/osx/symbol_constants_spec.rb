describe "Symbol - constants" do

  describe "should work" do

    it 'should support `nsautoresizingmask`' do
      :none.nsautoresizingmask.should == NSViewNotSizable
      :flexible_left.nsautoresizingmask.should == NSViewMinXMargin
      :flexible_width.nsautoresizingmask.should == NSViewWidthSizable
      :flexible_right.nsautoresizingmask.should == NSViewMaxXMargin
      :flexible_top.nsautoresizingmask.should == NSViewMaxYMargin
      :flexible_height.nsautoresizingmask.should == NSViewHeightSizable
      :flexible_bottom.nsautoresizingmask.should == NSViewMinYMargin
      :fill.nsautoresizingmask.should == NSViewWidthSizable | NSViewHeightSizable
      :fill_top.nsautoresizingmask.should == NSViewWidthSizable | NSViewMinYMargin
      :fill_bottom.nsautoresizingmask.should == NSViewWidthSizable | NSViewMaxYMargin
      :fill_left.nsautoresizingmask.should == NSViewHeightSizable | NSViewMaxXMargin
      :fill_right.nsautoresizingmask.should == NSViewHeightSizable | NSViewMinXMargin
      :fixed_top_left.nsautoresizingmask.should == NSViewMaxXMargin | NSViewMinYMargin
      :fixed_top_middle.nsautoresizingmask.should == NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin
      :fixed_top_right.nsautoresizingmask.should == NSViewMinXMargin | NSViewMinYMargin
      :fixed_middle_left.nsautoresizingmask.should == NSViewMaxYMargin | NSViewMinYMargin | NSViewMaxXMargin
      :fixed_middle.nsautoresizingmask.should == NSViewMaxYMargin | NSViewMinYMargin | NSViewMinXMargin | NSViewMaxXMargin
      :fixed_middle_right.nsautoresizingmask.should == NSViewMaxYMargin | NSViewMinYMargin | NSViewMinXMargin
      :fixed_bottom_left.nsautoresizingmask.should == NSViewMaxXMargin | NSViewMaxYMargin
      :fixed_bottom_middle.nsautoresizingmask.should == NSViewMinXMargin | NSViewMaxXMargin | NSViewMaxYMargin
      :fixed_bottom_right.nsautoresizingmask.should == NSViewMinXMargin | NSViewMaxYMargin
      :float_horizontal.nsautoresizingmask.should == NSViewMinXMargin | NSViewMaxXMargin
      :float_vertical.nsautoresizingmask.should == NSViewMaxYMargin | NSViewMinYMargin
    end

    it 'should support `nstextalignment`' do
      :left.nstextalignment.should == NSLeftTextAlignment
      :right.nstextalignment.should == NSRightTextAlignment
      :center.nstextalignment.should == NSCenterTextAlignment
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

    it 'should support `nsbuttontype`' do
      :momentary_light.nsbuttontype.should == NSMomentaryLightButton
      :push_on_push_off.nsbuttontype.should == NSPushOnPushOffButton
      :toggle.nsbuttontype.should == NSToggleButton
      :switch.nsbuttontype.should == NSSwitchButton
      :radio.nsbuttontype.should == NSRadioButton
      :momentary_change.nsbuttontype.should == NSMomentaryChangeButton
      :on_off.nsbuttontype.should == NSOnOffButton
      :momentary_push_in.nsbuttontype.should == NSMomentaryPushInButton
    end

    it 'should support `nsbezelstyle`' do
      :rounded.nsbezelstyle.should == NSRoundedBezelStyle
      :regular_square.nsbezelstyle.should == NSRegularSquareBezelStyle
      :thick_square.nsbezelstyle.should == NSThickSquareBezelStyle
      :thicker_square.nsbezelstyle.should == NSThickerSquareBezelStyle
      :disclosure.nsbezelstyle.should == NSDisclosureBezelStyle
      :shadowless_square.nsbezelstyle.should == NSShadowlessSquareBezelStyle
      :circular.nsbezelstyle.should == NSCircularBezelStyle
      :textured_square.nsbezelstyle.should == NSTexturedSquareBezelStyle
      :help_button.nsbezelstyle.should == NSHelpButtonBezelStyle
      :small_square.nsbezelstyle.should == NSSmallSquareBezelStyle
      :textured_rounded.nsbezelstyle.should == NSTexturedRoundedBezelStyle
      :round_rect.nsbezelstyle.should == NSRoundRectBezelStyle
      :recessed.nsbezelstyle.should == NSRecessedBezelStyle
      :rounded_disclosure.nsbezelstyle.should == NSRoundedDisclosureBezelStyle
      :inline.nsbezelstyle.should == NSInlineBezelStyle
    end

    it 'should support `nsfocusringtype`' do
      :default.nsfocusringtype.should == NSFocusRingTypeDefault
      :none.nsfocusringtype.should == NSFocusRingTypeNone
      :exterior.nsfocusringtype.should == NSFocusRingTypeExterior
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

  end

  describe "Aliases" do
    it 'should have alias for `nsautoresizingmask`' do
      :none.nsautoresizemask.should == :none.nsautoresizingmask
    end

    it 'should have alias for `nstextalignment`' do
      :left.nsalignment.should == :left.nstextalignment
    end

    it 'should have alias for `nsdatestyle`' do
      :no.nsdateformatterstyle.should == :no.nsdatestyle
    end

    it 'should have alias for `nsnumberstyle`' do
      :no.nsnumberformatterstyle.should == :no.nsnumberstyle
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

  end

  describe "not found" do
    it 'should not find nonexistant `nsautoresizingmask`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.nsautoresizingmask }
    end

    it 'should not find nonexistant `nstextalignment`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.nstextalignment }
    end

    it 'should not find nonexistant `nsdatestyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.nsdatestyle }
    end

    it 'should not find nonexistant `nsnumberstyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.nsnumberstyle }
    end

    it 'should not find nonexistant `nsbuttontype`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.nsbuttontype }
    end

    it 'should not find nonexistant `nsbezelstyle`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.nsbezelstyle }
    end

    it 'should not find nonexistant `nsfocusringtype`' do
      should.raise(SugarCubeNotFoundException) { :definitely_doesnt_exist_i_am_really_sure_of_it.nsfocusringtype }
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

  end

end
