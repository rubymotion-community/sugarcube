class UIBarButtonItem
  
  class << self
  
    def done(&action)
      sugarcube_barbuttonitem :done.uibarbuttonitem, action
    end

    def cancel(&action)
      sugarcube_barbuttonitem :cancel.uibarbuttonitem, action
    end
  
    def edit(&action)
      sugarcube_barbuttonitem :edit.uibarbuttonitem, action
    end
  
    def save(&action)
      sugarcube_barbuttonitem :save.uibarbuttonitem, action
    end
  
    def add(&action)
      sugarcube_barbuttonitem :add.uibarbuttonitem, action
    end
  
    def flexiblespace(&action)
      sugarcube_barbuttonitem :flexiblespace.uibarbuttonitem, action
    end
  
    def fixedspace(&action)
      sugarcube_barbuttonitem :fixedspace.uibarbuttonitem, action
    end
  
    def compose(&action)
      sugarcube_barbuttonitem :compose.uibarbuttonitem, action
    end
  
    def reply(&action)
      sugarcube_barbuttonitem :reply.uibarbuttonitem, action
    end
  
    def action(&action)
      sugarcube_barbuttonitem :action.uibarbuttonitem, action
    end
  
    def organize(&action)
      sugarcube_barbuttonitem :organize.uibarbuttonitem, action
    end
  
    def bookmarks(&action)
      sugarcube_barbuttonitem :bookmarks.uibarbuttonitem, action
    end
  
    def search(&action)
      sugarcube_barbuttonitem :search.uibarbuttonitem, action
    end
  
    def refresh(&action)
      sugarcube_barbuttonitem :refresh.uibarbuttonitem, action
    end
  
    def stop(&action)
      sugarcube_barbuttonitem :stop.uibarbuttonitem, action
    end
  
    def camera(&action)
      sugarcube_barbuttonitem :camera.uibarbuttonitem, action
    end
  
    def trash(&action)
      sugarcube_barbuttonitem :trash.uibarbuttonitem, action
    end
  
    def play(&action)
      sugarcube_barbuttonitem :play.uibarbuttonitem, action
    end
  
    def pause(&action)
      sugarcube_barbuttonitem :pause.uibarbuttonitem, action
    end
  
    def rewind(&action)
      sugarcube_barbuttonitem :rewind.uibarbuttonitem, action
    end

    def fastforward(&action)
      sugarcube_barbuttonitem :fastforward.uibarbuttonitem, action
    end

    def undo(&action)
      sugarcube_barbuttonitem :undo.uibarbuttonitem, action
    end

    def redo(&action)
      sugarcube_barbuttonitem :redo.uibarbuttonitem, action
    end

    def pagecurl(&action)
      sugarcube_barbuttonitem :pagecurl.uibarbuttonitem, action
    end

    def titled(title, style = :bordered.uibarbuttonstyle, &action)
      sugarcube_barbuttonitem_with_title(title, style, action)
    end
  
    def imaged(image, style = :bordered.uibarbuttonstyle, &action)
      sugarcube_barbuttonitem_with_image(image, style, action)
    end
  
  end

  # Adds the action and keeps a strong reference to the Proc object.
  def set_target_and_action target, action
    self.target = target
    self.action = 'sugarcube_handle_action:'
    @sugarcube_action = action
  end


private

  def self.sugarcube_barbuttonitem(systemitem, action)
    b = UIBarButtonItem.alloc.initWithBarButtonSystemItem systemitem, target:nil, action:nil
    b.set_target_and_action b, action
    b
  end

  def self.sugarcube_barbuttonitem_with_title(title, style, action)
    b = UIBarButtonItem.alloc.initWithTitle title, style:style, target:nil, action:nil
    b.set_target_and_action b, action
    b
  end

  def self.sugarcube_barbuttonitem_with_image(image, style, action)
    case image
    when Array
      b = UIBarButtonItem.alloc.initWithImage image.first, landscapeImagePhone:image.last, style:style, target:nil, action:nil
    else
      b = UIBarButtonItem.alloc.initWithImage image, style:style, target:nil, action:nil
    end
    b.set_target_and_action b, action
    b
  end

  def sugarcube_handle_action(sender)
    handler = @sugarcube_action
    if handler.arity == 0
      handler.call
    else
      handler.call(sender)
    end
  end

end
