# The following filters are available in iOS:
#
# * CIAdditionCompositing              * CIExposureAdjust          * CIPerspectiveTile
# * CIAffineClamp                      * CIFalseColor              * CIPerspectiveTransform
# * CIAffineTile                       * CIFlashTransition         * CIPerspectiveTransformWithExtent
# * CIAffineTransform                  * CIFourfoldReflectedTile   * CIPinchDistortion
# * CIBarsSwipeTransition              * CIFourfoldRotatedTile     * CIPixellate
# * CIBlendWithMask                    * CIFourfoldTranslatedTile  * CIRadialGradient
# * CIBloom                            * CIGammaAdjust             * CIFilter
# * CIBumpDistortion                   * CIGaussianBlur            * CISaturationBlendMode
# * CIBumpDistortionLinear             * CIGaussianGradient        * CIScreenBlendMode
# * CICheckerboardGenerator            * CIGlideReflectedTile      * CISepiaTone
# * CICircleSplashDistortion           * CIGloom                   * CISharpenLuminance
# * CICircularScreen                   * CIHardLightBlendMode      * CISixfoldReflectedTile
# * CIColorBlendMode                   * CIHatchedScreen           * CISixfoldRotatedTile
# * CIColorBurnBlendMode               * CIHighlightShadowAdjust   * CISoftLightBlendMode
# * CIColorControls                    * CIHoleDistortion          * CISourceAtopCompositing
# * CIColorCube                        * CIHueAdjust               * CISourceInCompositing
# * CIColorDodgeBlendMode              * CIHueBlendMode            * CISourceOutCompositing
# * CIFilter                           * CILanczosScaleTransform   * CISourceOverCompositing
# * CIColorMap                         * CILightenBlendMode        * CIStarShineGenerator
# * CIColorMatrix                      * CILightTunnel             * CIStraightenFilter
# * CIColorMonochrome                  * CILinearGradient          * CIStripesGenerator
# * CIColorPosterize                   * CILineScreen              * CISwipeTransition
# * CIConstantColorGenerator           * CILuminosityBlendMode     * CITemperatureAndTint
# * CICopyMachineTransition            * CIFilter                  * CIToneCurve
# * CICrop                             * CIFilter                  * CITriangleKaleidoscope
# * CIDarkenBlendMode                  * CIMaximumCompositing      * CITwelvefoldReflectedTile
# * CIDifferenceBlendMode              * CIFilter                  * CITwirlDistortion
# * CIDisintegrateWithMaskTransition   * CIMinimumCompositing      * CIUnsharpMask
# * CIDissolveTransition               * CIModTransition           * CIVibrance
# * CIDotScreen                        * CIMultiplyBlendMode       * CIVignette
# * CIEightfoldReflectedTile           * CIMultiplyCompositing     * CIVortexDistortion
# * CIExclusionBlendMode               * CIOverlayBlendMode        * CIWhitePointAdjust
#
# The following filters have not been added to iOS:     (as of 6/19/2013)
#
# * CIAreaAverage               * CIHexagonalPixellate
# * CIAreaHistogram             * CIKaleidoscope
# * CIAreaMaximum               * CILenticularHaloGenerator
# * CIAreaMaximumAlpha          * CILineOverlay
# * CIAreaMinimum               * CIMedianFilter
# * CIAreaMinimumAlpha          * CIMotionBlur
# * CIBoxBlur                   * CINoiseReduction
# * CICircularWrap              * CIOpTile
# * CICMYKHalftone              * CIPageCurlTransition
# * CIColumnAverage             * CIParallelogramTile
# * CIComicEffect               * CIPointillize
# * CICrystallize               * CIRippleTransition
# * CIDepthOfField              * CIRowAverage
# * CIDiscBlur                  * CIShadedMaterial
# * CIDisplacementDistortion    * CISpotColor
# * CIDroste                    * CISpotLight
# * CIEdges                     * CIStretchCrop
# * CIEdgeWork                  * CISunbeamsGenerator
# * CIGlassDistortion           * CITorusLensDistortion
# * CIGlassLozenge              * CITriangleTile
# * CIHeightFieldFromMask       * CIZoomBlur
#
class CIFilter

  ##|
  ##|  TYPE COERCTION
  ##|

  def uiimage
    ciimage.uiimage
  end

  def ciimage
    valueForKey('outputImage')
  end

  ##|
  ##|  FILTERS (FACTORY METHODS)
  ##|  http://developer.apple.com/library/mac/#documentation/GraphicsImaging/Reference/CoreImageFilterReference/Reference/reference.html
  ##|
  class << self

    # This helper instantiates the filter (raising an exception if it was
    # unsuccessful) and applies all the arguments from options (naming the args
    # according to `set_args`), translating names from `names`
    def _create_filter(filter_name, args, set_args=[], names={})
      filter = CIFilter.filterWithName(filter_name)
      raise "Unsupported filter #{filter_name.inspect}" unless filter

      # turn a list of arguments into a hash
      if args.length == 1 && Hash === args[0]
        options = args[0]
      else
        options = {}
        args.each_with_index do |arg, index|
          setter = set_args[index]
          raise "Cannot set option ##{index}" if setter.nil?
          options[setter] = arg
        end
      end

      options.each do |key, value|
        # translate the keys, but if there is no translation key then do nothing
        key = names[key] || key.to_s

        # translate the value if a block was given for that. `key` is always going
        # to be the CIImage key (not the alias, e.g. :radius => 'inputRadius')
        value = yield(key, value) if block_given?
        filter.setValue(value, forKey:key)
      end
      return filter
    end

    # CIAdditionCompositing
    def addition_compositing(*options)
      return _create_filter('CIAdditionCompositing', options, [:background], background: 'inputBackgroundImage')
    end

    # CIAffineClamp
    def affine_clamp(*options)
      return _create_filter('CIAffineClamp', options, [:transform], transform: 'inputTransform'
        ) do |key, value|
        if key == 'inputTransform' && CGAffineTransform === value
          ptr = Pointer.new(:id)
          ptr[0] = value
          NSValue.valueWithBytes(ptr, objCType:CGAffineTransform.type)
        else
          value
        end
      end
    end

    # CIAffineTile
    def affine_tile(*options)
      return _create_filter('CIAffineTile', options, [:transform], transform: 'inputTransform'
        ) do |key, value|
        if key == 'inputTransform' && CGAffineTransform === value
          ptr = Pointer.new(:id)
          ptr[0] = value
          NSValue.valueWithBytes(ptr, objCType:CGAffineTransform.type)
        else
          value
        end
      end
    end

    # CIAffineTransform
    def affine_transform(*options)
      return _create_filter('CIAffineTransform', options, [:transform], transform: 'inputTransform'
        ) do |key, value|
        if key == 'inputTransform' && CGAffineTransform === value
          ptr = Pointer.new(:id)
          ptr[0] = value
          NSValue.valueWithBytes(ptr, objCType:CGAffineTransform.type)
        else
          value
        end
      end
    end

    # CIBarsSwipeTransition
    def bars_swipe_transition(*options)
      return _create_filter('CIBarsSwipeTransition', options, [:target, :time],
        target: 'inputTargetImage', angle: 'inputAngle', width: 'inputWidth',
        offset: 'inputBarOffset', time: 'inputTime'
        ) do |key, value|
        if key == 'inputTargetImage'
          value.ciimage
        else
          value
        end
      end
    end

    # CIBlendWithMask
    def blend_with_mask(*options)
      return _create_filter('CIBlendWithMask', options, [:background, :mask], background: 'inputBackgroundImage', mask: 'inputMaskImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIBloom
    def bloom(*options)
      return _create_filter('CIBloom', options, [:radius, :intensity], radius: 'inputRadius', intensity: 'inputIntensity')
    end

    # CIBumpDistortion
    #                                                                      PENDING
    def bump_distortion(*options)
      return _create_filter('CIBumpDistortion', options)
    end

    # CIBumpDistortionLinear
    #                                                                      PENDING
    def bump_distortion_linear(*options)
      return _create_filter('CIBumpDistortionLinear', options)
    end

    # CICheckerboardGenerator
    def checkerboard_generator(*options)
      return _create_filter('CICheckerboardGenerator', options, [:width, :color0, :color1],
        width: 'inputWidth', color0: 'inputColor0', color1: 'inputColor1', sharpness: 'inputSharpness'
        ) do |key, value|
        if key == 'inputColor0' || key == 'inputColor1'
          value.cicolor
        else
          value
        end
      end
    end

    # CICircleSplashDistortion
    def circle_splash_distortion(*options)
      return _create_filter('CICircleSplashDistortion', options, [:radius, :center],
        radius: 'inputRadius', center: 'inputCenter'
        ) do |key, value|
        if key == 'inputCenter' && ! CIVector === value
          CIVector.vectorWithX(value[0], Y: value[1])
        else
          value
        end
      end
    end

    # CICircularScreen
    #                                                                      PENDING
    def circular_screen(*options)
      return _create_filter('CICircularScreen', options)
    end

    # CIColorBlendMode
    def color_blend_mode(*options)
      return _create_filter('CIColorBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIColorBurnBlendMode
    def color_burn_blend_mode(*options)
      return _create_filter('CIColorBurnBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIColorControls
    def color_controls(*options)
      return _create_filter('CIColorControls', options, [:saturation, :brightness, :contrast],
        saturation: 'inputSaturation', brightness: 'inputBrightness', contrast: 'inputContrast')
    end

    # CIColorCube
    #                                                                      PENDING
    def color_cube(*options)
      return _create_filter('CIColorCube', options)
    end

    # CIColorDodgeBlendMode
    def color_dodge_blend_mode(*options)
      return _create_filter('CIColorDodgeBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIColorInvert
    def color_invert()
      return CIFilter.filterWithName('CIColorInvert')
    end

    # CIColorMap
    def color_map(*options)
      return _create_filter('CIColorMap', options, [:gradient], gradient: 'inputGradientImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIColorMatrix
    #                                                                      PENDING
    def color_matrix(*options)
      return _create_filter('CIColorMatrix', options)
    end

    # CIColorMonochrome
    #                                                                      PENDING
    def color_monochrome(*options)
      return _create_filter('CIColorMonochrome', options)
    end

    # CIColorPosterize
    def color_posterize(*options)
      return _create_filter('CIColorPosterize', options, [:levels], levels: 'inputLevels')
    end

    # CIConstantColorGenerator
    def constant_color_generator(*options)
      return _create_filter('CIConstantColorGenerator', options, [:color], color: 'inputColor'
        ) do |key, value|
        value.cicolor
      end
    end

    # CICopyMachineTransition
    #                                                                      PENDING
    def copy_machine_transition(*options)
      return _create_filter('CICopyMachineTransition', options)
    end

    # CICrop
    def crop(*options)
      return _create_filter('CICrop', options, [:rectangle], rectangle: 'inputRectangle') do |key, value|
        rect = SugarCube::CoreGraphics::Rect(value)
        CIVector.alloc.initWithX( rect.origin.x,
                               Y: rect.origin.y,
                               Z: rect.size.width,
                               W: rect.size.height)
      end
    end

    # CIDarkenBlendMode
    def darken_blend_mode(*options)
      return _create_filter('CIDarkenBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIDifferenceBlendMode
    def difference_blend_mode(*options)
      return _create_filter('CIDifferenceBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIDisintegrateWithMaskTransition
    #                                                                      PENDING
    def disintegrate_with_mask_transition(*options)
      return _create_filter('CIDisintegrateWithMaskTransition', options)
    end

    # CIDissolveTransition
    #                                                                      PENDING
    def dissolve_transition(*options)
      return _create_filter('CIDissolveTransition', options)
    end

    # CIDotScreen
    #                                                                      PENDING
    def dot_screen(*options)
      return _create_filter('CIDotScreen', options)
    end

    # CIEightfoldReflectedTile
    #                                                                      PENDING
    def eightfold_reflected_tile(*options)
      return _create_filter('CIEightfoldReflectedTile', options)
    end

    # CIExclusionBlendMode
    def exclusion_blend_mode(*options)
      return _create_filter('CIExclusionBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIExposureAdjust
    def exposure_adjust(*options)
      return _create_filter('CIExposureAdjust', options, [:ev], ev: 'inputEV')
    end

    # CIFalseColor
    def false_color(*options)
      return _create_filter('CIFalseColor', options, [:color0, :color1], color0: 'inputColor0', color1: 'inputColor1'
        ) do |key, value|
        value.cicolor
      end
    end

    # CIFlashTransition
    #                                                                      PENDING
    def flash_transition(*options)
      return _create_filter('CIFlashTransition', options)
    end

    # CIFourfoldReflectedTile
    #                                                                      PENDING
    def fourfold_reflected_tile(*options)
      return _create_filter('CIFourfoldReflectedTile', options)
    end

    # CIFourfoldRotatedTile
    #                                                                      PENDING
    def fourfold_rotated_tile(*options)
      return _create_filter('CIFourfoldRotatedTile', options)
    end

    # CIFourfoldTranslatedTile
    #                                                                      PENDING
    def fourfold_translated_tile(*options)
      return _create_filter('CIFourfoldTranslatedTile', options)
    end

    # CIGammaAdjust
    def gamma_adjust(*options)
      return _create_filter('CIGammaAdjust', options, [:power], power: 'inputPower')
    end

    # CIGaussianBlur
    def gaussian_blur(*options)
      return _create_filter('CIGaussianBlur', options, [:radius], radius: 'inputRadius')
    end

    # CIGaussianGradient
    #                                                                      PENDING
    def gaussian_gradient(*options)
      return _create_filter('CIGaussianGradient', options)
    end

    # CIGlideReflectedTile
    #                                                                      PENDING
    def glide_reflected_tile(*options)
      return _create_filter('CIGlideReflectedTile', options)
    end

    # CIGloom
    def gloom(*options)
      return _create_filter('CIGloom', options, [:intensity, :radius], intensity: 'inputIntensity', radius: 'inputRadius')
    end

    # CIHardLightBlendMode
    def hard_light_blend_mode(*options)
      return _create_filter('CIHardLightBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIHatchedScreen
    #                                                                      PENDING
    def hatched_screen(*options)
      return _create_filter('CIHatchedScreen', options)
    end

    # CIHighlightShadowAdjust
    def highlight_shadow_adjust(*options)
      return _create_filter('CIHighlightShadowAdjust', options, [:highlight, :shadow], highlight: 'inputHighlightAmount', shadow: 'inputShadowAmount')
    end

    # CIHoleDistortion
    #                                                                      PENDING
    def hole_distortion(*options)
      return _create_filter('CIHoleDistortion', options)
    end

    # CIHueAdjust
    def hue_adjust(*options)
      return _create_filter('CIHueAdjust', options, [:angle], angle: 'inputAngle')
    end

    # CIHueBlendMode
    def hue_blend_mode(*options)
      return _create_filter('CIHueBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CILanczosScaleTransform
    def lanczos_scale_transform(*options)
      return _create_filter('CILanczosScaleTransform', options, [:scale, :aspect_ratio], scale: 'inputScale', aspect_ratio: 'inputAspectRatio')
    end

    # CILightenBlendMode
    def lighten_blend_mode(*options)
      return _create_filter('CILightenBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CILightTunnel
    #                                                                      PENDING
    def light_tunnel(*options)
      return _create_filter('CILightTunnel', options)
    end

    # CILinearGradient
    #                                                                      PENDING
    def linear_gradient(*options)
      return _create_filter('CILinearGradient', options)
    end

    # CILineScreen
    #                                                                      PENDING
    def line_screen(*options)
      return _create_filter('CILineScreen', options)
    end

    # CILuminosityBlendMode
    def luminosity_blend_mode(*options)
      return _create_filter('CILuminosityBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIMaskToAlpha
    def mask_to_alpha()
      return CIFilter.filterWithName('CIMaskToAlpha')
    end

    # CIMaximumComponent
    def maximum_component()
      return CIFilter.filterWithName('CIMaximumComponent')
    end

    # CIMaximumCompositing
    def maximum_compositing(*options)
      return _create_filter('CIMaximumCompositing', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIMinimumComponent
    def minimum_component()
      return CIFilter.filterWithName('CIMinimumComponent')
    end

    # CIMinimumCompositing
    def minimum_compositing(*options)
      return _create_filter('CIMinimumCompositing', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIModTransition
    #                                                                      PENDING
    def mod_transition(*options)
      return _create_filter('CIModTransition', options)
    end

    # CIMultiplyBlendMode
    def multiply_blend_mode(*options)
      return _create_filter('CIMultiplyBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIMultiplyCompositing
    def multiply_compositing(*options)
      return _create_filter('CIMultiplyCompositing', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIOverlayBlendMode
    def overlay_blend_mode(*options)
      return _create_filter('CIOverlayBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIPerspectiveTile
    #                                                                      PENDING
    def perspective_tile(*options)
      return _create_filter('CIPerspectiveTile', options)
    end

    # CIPerspectiveTransform
    #                                                                      PENDING
    def perspective_transform(*options)
      return _create_filter('CIPerspectiveTransform', options)
    end

    # CIPerspectiveTransformWithExtent
    #                                                                      PENDING
    def perspective_transform_with_extent(*options)
      return _create_filter('CIPerspectiveTransformWithExtent', options)
    end

    # CIPinchDistortion
    #                                                                      PENDING
    def pinch_distortion(*options)
      return _create_filter('CIPinchDistortion', options)
    end

    # CIPixellate
    #                                                                      PENDING
    def pixellate(*options)
      return _create_filter('CIPixellate', options)
    end

    # CIRadialGradient
    #                                                                      PENDING
    def radial_gradient(*options)
      return _create_filter('CIRadialGradient', options)
    end

    # CIRandomGenerator
    def random_generator()
      return CIFilter.filterWithName('CIRandomGenerator')
    end

    # CISaturationBlendMode
    def saturation_blend_mode(*options)
      return _create_filter('CISaturationBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIScreenBlendMode
    def screen_blend_mode(*options)
      return _create_filter('CIScreenBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CISepiaTone
    def sepia_tone(*options)
      return _create_filter('CISepiaTone', options, [:intensity], intensity: 'inputIntensity')
    end

    # CISharpenLuminance
    def sharpen_luminance(*options)
      return _create_filter('CISharpenLuminance', options, [:sharpness], sharpness: 'inputSharpness')
    end

    # CISixfoldReflectedTile
    #                                                                      PENDING
    def sixfold_reflected_tile(*options)
      return _create_filter('CISixfoldReflectedTile', options)
    end

    # CISixfoldRotatedTile
    #                                                                      PENDING
    def sixfold_rotated_tile(*options)
      return _create_filter('CISixfoldRotatedTile', options)
    end

    # CISoftLightBlendMode
    def soft_light_blend_mode(*options)
      return _create_filter('CISoftLightBlendMode', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CISourceAtopCompositing
    def source_atop_compositing(*options)
      return _create_filter('CISourceAtopCompositing', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CISourceInCompositing
    def source_in_compositing(*options)
      return _create_filter('CISourceInCompositing', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CISourceOutCompositing
    def source_out_compositing(*options)
      return _create_filter('CISourceOutCompositing', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CISourceOverCompositing
    def source_over_compositing(*options)
      return _create_filter('CISourceOverCompositing', options, [:background], background: 'inputBackgroundImage'
        ) do |key, value|
        value.ciimage
      end
    end

    # CIStarShineGenerator
    #                                                                      PENDING
    def star_shine_generator(*options)
      return _create_filter('CIStarShineGenerator', options)
    end

    # CIStraightenFilter
    def straighten_filter(*options)
      return _create_filter('CIStraightenFilter', options, [:angle], angle: 'inputAngle')
    end

    # CIStripesGenerator
    #                                                                      PENDING
    def stripes_generator(*options)
      return _create_filter('CIStripesGenerator', options)
    end

    # CISwipeTransition
    #                                                                      PENDING
    def swipe_transition(*options)
      return _create_filter('CISwipeTransition', options)
    end

    # CITemperatureAndTint
    #                                                                      PENDING
    def temperature_and_tint(*options)
      return _create_filter('CITemperatureAndTint', options)
    end

    # CIToneCurve
    #                                                                      PENDING
    def tone_curve(*options)
      return _create_filter('CIToneCurve', options)
    end

    # CITriangleKaleidoscope
    #                                                                      PENDING
    def triangle_kaleidoscope(*options)
      return _create_filter('CITriangleKaleidoscope', options)
    end

    # CITwelvefoldReflectedTile
    #                                                                      PENDING
    def twelvefold_reflected_tile(*options)
      return _create_filter('CITwelvefoldReflectedTile', options)
    end

    # CITwirlDistortion
    #                                                                      PENDING
    def twirl_distortion(*options)
      return _create_filter('CITwirlDistortion', options)
    end

    # CIUnsharpMask
    def unsharp_mask(*options)
      return _create_filter('CIUnsharpMask', options, [:intensity, :radius], intensity: 'inputIntensity', radius: 'inputRadius')
    end

    # CIVibrance
    def vibrance(*options)
      return _create_filter('CIVibrance', options, [:amount], amount: 'inputAmount')
    end

    # CIVignette
    def vignette(*options)
      return _create_filter('CIVignette', options, [:radius, :intensity], radius: 'inputRadius', intensity: 'inputIntensity')
    end

    # CIVortexDistortion
    #                                                                      PENDING
    def vortex_distortion(*options)
      return _create_filter('CIVortexDistortion', options)
    end

    # CIWhitePointAdjust
    def white_point_adjust(*options)
      return _create_filter('CIWhitePointAdjust', options, [:color], color: 'inputColor') do |key, value|
        value.cicolor
      end
    end

  end

end
