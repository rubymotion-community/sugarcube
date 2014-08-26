describe "CIFilter extensions" do

  it "should implement the CIAdditionCompositing filter" do
    -> {
      CIFilter.addition_compositing.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIAffineClamp filter" do
    -> {
      CIFilter.affine_clamp.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIAffineTile filter" do
    -> {
      CIFilter.affine_tile.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIAffineTransform filter" do
    -> {
      CIFilter.affine_transform.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIBarsSwipeTransition filter" do
    -> {
      CIFilter.bars_swipe_transition.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIBlendWithMask filter" do
    -> {
      CIFilter.blend_with_mask.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIBloom filter" do
    -> {
      CIFilter.bloom.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIBumpDistortion filter" do
    -> {
      CIFilter.bump_distortion.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIBumpDistortionLinear filter" do
    -> {
      CIFilter.bump_distortion_linear.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CICheckerboardGenerator filter" do
    -> {
      CIFilter.checkerboard_generator.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CICircleSplashDistortion filter" do
    -> {
      CIFilter.circle_splash_distortion.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CICircularScreen filter" do
    -> {
      CIFilter.circular_screen.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIColorBlendMode filter" do
    -> {
      CIFilter.color_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIColorBurnBlendMode filter" do
    -> {
      CIFilter.color_burn_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIColorControls filter" do
    -> {
      CIFilter.color_controls.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIColorCube filter" do
    -> {
      CIFilter.color_cube.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIColorDodgeBlendMode filter" do
    -> {
      CIFilter.color_dodge_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIColorInvert filter" do
    -> {
      CIFilter.color_invert.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIColorMap filter" do
    -> {
      CIFilter.color_map.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIColorMatrix filter" do
    -> {
      CIFilter.color_matrix.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIColorMonochrome filter" do
    -> {
      CIFilter.color_monochrome.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIColorPosterize filter" do
    -> {
      CIFilter.color_posterize.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIConstantColorGenerator filter" do
    -> {
      CIFilter.constant_color_generator.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CICopyMachineTransition filter" do
    -> {
      CIFilter.copy_machine_transition.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CICrop filter" do
    -> {
      CIFilter.crop.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIDarkenBlendMode filter" do
    -> {
      CIFilter.darken_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIDifferenceBlendMode filter" do
    -> {
      CIFilter.difference_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIDisintegrateWithMaskTransition filter" do
    -> {
      CIFilter.disintegrate_with_mask_transition.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIDissolveTransition filter" do
    -> {
      CIFilter.dissolve_transition.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIDotScreen filter" do
    -> {
      CIFilter.dot_screen.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIEightfoldReflectedTile filter" do
    -> {
      CIFilter.eightfold_reflected_tile.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIExclusionBlendMode filter" do
    -> {
      CIFilter.exclusion_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIExposureAdjust filter" do
    -> {
      CIFilter.exposure_adjust.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIFalseColor filter" do
    -> {
      CIFilter.false_color.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIFlashTransition filter" do
    -> {
      CIFilter.flash_transition.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIFourfoldReflectedTile filter" do
    -> {
      CIFilter.fourfold_reflected_tile.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIFourfoldRotatedTile filter" do
    -> {
      CIFilter.fourfold_rotated_tile.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIFourfoldTranslatedTile filter" do
    -> {
      CIFilter.fourfold_translated_tile.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIGammaAdjust filter" do
    -> {
      CIFilter.gamma_adjust.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIGaussianBlur filter" do
    -> {
      CIFilter.gaussian_blur.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIGaussianGradient filter" do
    -> {
      CIFilter.gaussian_gradient.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIGlideReflectedTile filter" do
    -> {
      CIFilter.glide_reflected_tile.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIGloom filter" do
    -> {
      CIFilter.gloom.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIHardLightBlendMode filter" do
    -> {
      CIFilter.hard_light_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIHatchedScreen filter" do
    -> {
      CIFilter.hatched_screen.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIHighlightShadowAdjust filter" do
    -> {
      CIFilter.highlight_shadow_adjust.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIHoleDistortion filter" do
    -> {
      CIFilter.hole_distortion.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIHueAdjust filter" do
    -> {
      CIFilter.hue_adjust.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIHueBlendMode filter" do
    -> {
      CIFilter.hue_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CILanczosScaleTransform filter" do
    -> {
      CIFilter.lanczos_scale_transform.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CILightenBlendMode filter" do
    -> {
      CIFilter.lighten_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CILightTunnel filter" do
    -> {
      CIFilter.light_tunnel.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CILinearGradient filter" do
    -> {
      CIFilter.linear_gradient.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CILineScreen filter" do
    -> {
      CIFilter.line_screen.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CILuminosityBlendMode filter" do
    -> {
      CIFilter.luminosity_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIMaximumCompositing filter" do
    -> {
      CIFilter.maximum_compositing.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIMinimumCompositing filter" do
    -> {
      CIFilter.minimum_compositing.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIModTransition filter" do
    -> {
      CIFilter.mod_transition.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIMultiplyBlendMode filter" do
    -> {
      CIFilter.multiply_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIMultiplyCompositing filter" do
    -> {
      CIFilter.multiply_compositing.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIOverlayBlendMode filter" do
    -> {
      CIFilter.overlay_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIPerspectiveTile filter" do
    -> {
      CIFilter.perspective_tile.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIPerspectiveTransform filter" do
    -> {
      CIFilter.perspective_transform.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIPerspectiveTransformWithExtent filter" do
    -> {
      CIFilter.perspective_transform_with_extent.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIPinchDistortion filter" do
    -> {
      CIFilter.pinch_distortion.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIPixellate filter" do
    -> {
      CIFilter.pixellate.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIRadialGradient filter" do
    -> {
      CIFilter.radial_gradient.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CISaturationBlendMode filter" do
    -> {
      CIFilter.saturation_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIScreenBlendMode filter" do
    -> {
      CIFilter.screen_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CISepiaTone filter" do
    -> {
      CIFilter.sepia_tone.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CISharpenLuminance filter" do
    -> {
      CIFilter.sharpen_luminance.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CISixfoldReflectedTile filter" do
    -> {
      CIFilter.sixfold_reflected_tile.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CISixfoldRotatedTile filter" do
    -> {
      CIFilter.sixfold_rotated_tile.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CISoftLightBlendMode filter" do
    -> {
      CIFilter.soft_light_blend_mode.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CISourceAtopCompositing filter" do
    -> {
      CIFilter.source_atop_compositing.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CISourceInCompositing filter" do
    -> {
      CIFilter.source_in_compositing.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CISourceOutCompositing filter" do
    -> {
      CIFilter.source_out_compositing.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CISourceOverCompositing filter" do
    -> {
      CIFilter.source_over_compositing.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIStarShineGenerator filter" do
    -> {
      CIFilter.star_shine_generator.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIStraightenFilter filter" do
    -> {
      CIFilter.straighten_filter.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIStripesGenerator filter" do
    -> {
      CIFilter.stripes_generator.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CISwipeTransition filter" do
    -> {
      CIFilter.swipe_transition.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CITemperatureAndTint filter" do
    -> {
      CIFilter.temperature_and_tint.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIToneCurve filter" do
    -> {
      CIFilter.tone_curve.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CITriangleKaleidoscope filter" do
    -> {
      CIFilter.triangle_kaleidoscope.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CITwelvefoldReflectedTile filter" do
    -> {
      CIFilter.twelvefold_reflected_tile.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CITwirlDistortion filter" do
    -> {
      CIFilter.twirl_distortion.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIUnsharpMask filter" do
    -> {
      CIFilter.unsharp_mask.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIVibrance filter" do
    -> {
      CIFilter.vibrance.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIVignette filter" do
    -> {
      CIFilter.vignette.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIVortexDistortion filter" do
    -> {
      CIFilter.vortex_distortion.should.is_a(CIFilter)
    }.should.not.raise
  end

  it "should implement the CIWhitePointAdjust filter" do
    -> {
      CIFilter.white_point_adjust.should.is_a(CIFilter)
    }.should.not.raise
  end

end
