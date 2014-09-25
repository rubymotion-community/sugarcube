class NSError

  def self.new(message='Error', options={})
    domain = options[:domain] || 'Error'
    code = options[:code] || 0
    info = { NSLocalizedDescriptionKey => message }
    if options[:userInfo]
      info.merge! options[:userInfo]
    end
    NSError.alloc.initWithDomain(domain, code: code, userInfo: info)
  end

end
