def SugarCube.log(message=nil)
  @log ||= []

  if message.nil?
    return @log
  end

  if suppress?
    log << message
  elsif log?
    SugarCube.stderr(message)
  end

  self
end

def SugarCube.flush_log(notification=nil)
  return unless @log && ! @log.empty?

  output = "SugarCube recorded the following warnings:"
  @log.uniq.each do |message|
    output << "\n"
    output << message
  end
  SugarCube.stderr(output)
  @log = nil
end

def SugarCube.log?(value=nil)
  if value.nil?
    if @logging.nil?
      @logging = (RUBYMOTION_ENV == 'development')
    end
    @logging
  else
    @logging = value
    unless @logging
      @log = nil
    end
  end
end

def SugarCube.suppress?(value=nil)
  if value.nil?
    @suppress
  else
    @suppress = value
    unless @suppress
      @log = nil
    end
  end
end
