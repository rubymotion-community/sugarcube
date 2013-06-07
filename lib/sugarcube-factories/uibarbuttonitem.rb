# Factory methods for UIBarButtonItem
class UIBarButtonItem

  class << self

    def done(&action)
      sugarcube_barbuttonitem(:done, action)
    end

    def cancel(&action)
      sugarcube_barbuttonitem(:cancel, action)
    end

    def edit(&action)
      sugarcube_barbuttonitem(:edit, action)
    end

    def save(&action)
      sugarcube_barbuttonitem(:save, action)
    end

    def add(&action)
      sugarcube_barbuttonitem(:add, action)
    end

    def flexiblespace(&action)
      sugarcube_barbuttonitem(:flexiblespace, action)
    end

    def fixedspace(&action)
      sugarcube_barbuttonitem(:fixedspace, action)
    end

    def compose(&action)
      sugarcube_barbuttonitem(:compose, action)
    end

    def reply(&action)
      sugarcube_barbuttonitem(:reply, action)
    end

    def action(&action)
      sugarcube_barbuttonitem(:action, action)
    end

    def organize(&action)
      sugarcube_barbuttonitem(:organize, action)
    end

    def bookmarks(&action)
      sugarcube_barbuttonitem(:bookmarks, action)
    end

    def search(&action)
      sugarcube_barbuttonitem(:search, action)
    end

    def refresh(&action)
      sugarcube_barbuttonitem(:refresh, action)
    end

    def stop(&action)
      sugarcube_barbuttonitem(:stop, action)
    end

    def camera(&action)
      sugarcube_barbuttonitem(:camera, action)
    end

    def trash(&action)
      sugarcube_barbuttonitem(:trash, action)
    end

    def play(&action)
      sugarcube_barbuttonitem(:play, action)
    end

    def pause(&action)
      sugarcube_barbuttonitem(:pause, action)
    end

    def rewind(&action)
      sugarcube_barbuttonitem(:rewind, action)
    end

    def fastforward(&action)
      sugarcube_barbuttonitem(:fastforward, action)
    end

    def undo(&action)
      sugarcube_barbuttonitem(:undo, action)
    end

    def redo(&action)
      sugarcube_barbuttonitem(:redo, action)
    end

    def pagecurl(&action)
      sugarcube_barbuttonitem(:pagecurl, action)
    end

    def titled(title, style = :bordered, &action)
      sugarcube_barbuttonitem_with_title(title, style, action)
    end

    def imaged(image, style = :bordered, &action)
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
    systemitem = systemitem.uibarbuttonitem if systemitem.respond_to?(:uibarbuttonitem)
    b = UIBarButtonItem.alloc.initWithBarButtonSystemItem(systemitem, target:nil, action:nil)
    b.set_target_and_action b, action
    b
  end

  def self.sugarcube_barbuttonitem_with_title(title, style, action)
    style = style.uibarbuttonstyle if style.respond_to?(:uibarbuttonstyle)
    b = UIBarButtonItem.alloc.initWithTitle(title, style:style, target:nil, action:nil)
    b.set_target_and_action b, action
    b
  end

  def self.sugarcube_barbuttonitem_with_image(image, style, action)
    style = style.uibarbuttonstyle if style.respond_to?(:uibarbuttonstyle)
    case image
    when Array
      b = UIBarButtonItem.alloc.initWithImage(image.first.uiimage, landscapeImagePhone:image.last.uiimage, style:style, target:nil, action:nil)
    else
      b = UIBarButtonItem.alloc.initWithImage(image.uiimage, style:style, target:nil, action:nil)
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
