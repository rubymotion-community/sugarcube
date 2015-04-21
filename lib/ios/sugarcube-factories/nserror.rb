class NSError

  # @example
  #     NSError.error('just a simple error message')
  #     NSError.error('just a simple error message',
  #       domain: 'foo',
  #       code: 255,
  #       userInfo: { 'object' => 'foo' }
  #     )
  def self.error(message='Error', options={})
    domain = options[:domain] || 'Error'
    code = options[:code] || 0
    info = { NSLocalizedDescriptionKey => message }
    if options[:userInfo]
      info.merge! options[:userInfo]
    end
    NSError.alloc.initWithDomain(domain, code: code, userInfo: info)
  end

end
