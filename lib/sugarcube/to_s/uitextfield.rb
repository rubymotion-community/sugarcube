class UITextField

  def to_s(options={})
    text = self.text
    if text && text.length > 20
      text = text[0..20] + '...'
    end
    placeholder = self.placeholder
    if placeholder && placeholder.length > 20
      placeholder = placeholder[0..20] + '...'
    end
    super options.merge(inner: 'text: ' + text.inspect + ', placeholder: ' + placeholder.inspect)
  end

end
