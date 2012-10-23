class UILabel

  def to_s(options={})
    super options.merge(inner: 'text: ' + text.inspect)
  end

end
