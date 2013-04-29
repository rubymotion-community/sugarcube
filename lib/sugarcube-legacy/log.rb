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