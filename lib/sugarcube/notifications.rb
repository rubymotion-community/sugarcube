class NSString

  def post_notification(object=nil, user_info=nil)
    if user_info and not user_info.is_a? Hash
      raise TypeError("Invalid argument #{user_info.class.name} sent to String.post_notification")
    end

    if user_info
      NSNotificationCenter.defaultCenter.postNotificationName(self, object:object, userInfo:user_info)
    else
      NSNotificationCenter.defaultCenter.postNotificationName(self, object:object)
    end
  end

  def add_observer(observer, message, object=nil)
    NSNotificationCenter.defaultCenter.addObserver(observer,
            selector: message,
            name: self,
            object: object)
  end

  def remove_observer(observer, object=nil)
    NSNotificationCenter.defaultCenter.removeObserver(observer, name:self, object:object)
  end

end
