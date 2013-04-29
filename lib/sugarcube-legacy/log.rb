module SugarCube
  module Legacy
    module_function

    def log(message=nil)
      @log ||= []

      if message.nil?
        return @log
      end

      if log?
        log << message
      else
        NSLog(message)
      end

      self
    end

    def flush_log(notification=nil)
      return unless @log && ! @log.empty?

      output = "SugarCube recorded the following warnings:"
      @log.uniq.each do |message|
        output << "\n"
        output << message
      end
      NSLog(output)
      @log = nil
    end

    def log?(value=nil)
      if value.nil?
        @logging
      else
        @logging = value
        unless @logging
          @log = nil
        end
      end
    end

  end
end