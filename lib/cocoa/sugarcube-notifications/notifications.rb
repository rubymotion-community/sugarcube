class NSNotification

  def [](key)
    userInfo && userInfo[key]
  end

end


class NSString

  def post_notification(object=nil, user_info=nil)
    if user_info && ! user_info.is_a?(Hash)
      raise TypeError("Invalid argument #{user_info.class.to_s} sent to String.post_notification")
    end

    if user_info
      NSNotificationCenter.defaultCenter.postNotificationName(self, object: object, userInfo: user_info)
    else
      NSNotificationCenter.defaultCenter.postNotificationName(self, object: object)
    end
  end

  def add_observer(target, action, object=nil)
    NSNotificationCenter.defaultCenter.addObserver(target,
      selector: action,
      name: self,
      object: object)
  end

  def remove_observer(target, object=nil)
    NSNotificationCenter.defaultCenter.removeObserver(target, name: self, object: object)
  end

end
