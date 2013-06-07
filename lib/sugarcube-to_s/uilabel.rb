class UILabel

  def to_s(options={})
    text = self.text
    if text && text.length > 20
      text = text[0..20] + '...'
    end
    super options.merge(inner: 'text: ' + text.inspect)
  end

end
