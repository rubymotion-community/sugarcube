=begin
"my notification".observe(obj, :notified)
  # => NSNotificationCenter.defaultCenter.addObserver(obj, selector::'notified:', name:"my notification", object: nil)
"my notification".observe(obj) { |notification| puts notification }
  # => NSNotificationCenter.defaultCenter.addObserver(obj, selector::'__sugarcube_notified__:', name:"my notification", object: Proc.new { |notification| puts notification })
"my notification".observe { |notification| puts notification }
  # => NSNotificationCenter.defaultCenter.addObserverForName("my notification", object: nil, queue:NSOperationQueue.mainQueue, usingBlock:{ |notification| puts notification })

"my notification".removeObserver(obj)
  # => NSNotificationCenter.defaultCenter.removeObserver(object, name:"my notification", object: nil)
"my notification".removeObserver(obj, obj2)
  # => NSNotificationCenter.defaultCenter.removeObserver(object, name:"my notification", object: obj2)
=end

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
