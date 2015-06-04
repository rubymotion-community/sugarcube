class AttributedStringController < UIViewController

  def viewDidLoad
    @label = ('Hi!'.underline + '2'.attrd.superscript).uilabel
    @label.center = self.view.center
    @label.textColor = :white.uicolor
    self.view << @label
  end

end
