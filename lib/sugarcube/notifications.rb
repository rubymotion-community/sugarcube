

class String

  def post_notification(object=nil, user_info=nil)
    if user_info and not Hash === user_info
      raise TypeError("Invalid argument #{user_info.class.name} sent to String.post_notification")
    end

    if user_info
      NSNotificationCenter.defaultCenter.postNotificationName(self, object:object, userInfo:user_info)
    else
      NSNotificationCenter.defaultCenter.postNotificationName(self, object:object)
    end
  end

end


class Object
end
