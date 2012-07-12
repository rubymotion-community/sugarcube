

class UIImage
  def uiimage ; self ; end


  def uicolor(alpha=nil)
    color = UIColor.colorWithPatternImage(self)
    if not alpha.nil?
      color = color.colorWithAlphaComponent(alpha.to_f)
    end

    color
  end

end
