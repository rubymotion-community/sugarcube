class NSNumber

  def later(user_info=nil, &fire)
    NSTimer.scheduledTimerWithTimeInterval(self, target: fire, selector: 'call:', userInfo: user_info, repeats: false)
  end

  def every(user_info=nil, &fire)
    NSTimer.scheduledTimerWithTimeInterval(self, target: fire, selector: 'call:', userInfo: user_info, repeats: true)
  end

end


module SugarCube
  module Timer
    module_function

    def every(time, user_info=nil, &fire)
      time.every user_info, &fire
    end

    def after(time, user_info=nil, &fire)
      time.later user_info, &fire
    end
  end
end


class NSTimer
  def self.every(time, user_info=nil, &fire)
    time.every user_info, &fire
  end

  def self.after(time, user_info=nil, &fire)
    time.later user_info, &fire
  end
end
