class AnimationChainController < UIViewController

  def loadView
    super.tap do
      @label = 'Hi!'.uilabel
      @label.center = self.view.center
      @label.textColor = :white.uicolor
      self.view << @label
    end
  end

end
