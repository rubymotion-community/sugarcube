# Factory methods for UIBarButtonItem
class UIBarButtonItem

  class << self

    def done(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemDone, action)
    end

    def cancel(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemCancel, action)
    end

    def edit(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemEdit, action)
    end

    def save(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemSave, action)
    end

    def add(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemAdd, action)
    end

    # deprecated
    def flexiblespace(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemFlexibleSpace, action)
    end

    def flexible_space(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemFlexibleSpace, action)
    end

    # deprecated
    def fixedspace(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemFixedSpace, action)
    end

    def fixed_space(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemFixedSpace, action)
    end

    def compose(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemCompose, action)
    end

    def reply(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemReply, action)
    end

    def action(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemAction, action)
    end

    def organize(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemOrganize, action)
    end

    def bookmarks(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemBookmarks, action)
    end

    def search(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemSearch, action)
    end

    def refresh(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemRefresh, action)
    end

    def stop(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemStop, action)
    end

    def camera(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemCamera, action)
    end

    def trash(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemTrash, action)
    end

    def play(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemPlay, action)
    end

    def pause(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemPause, action)
    end

    def rewind(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemRewind, action)
    end

    # deprecated
    def fastforward(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemFastForward, action)
    end

    def fast_forward(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemFastForward, action)
    end

    def undo(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemUndo, action)
    end

    def redo(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemRedo, action)
    end

    # deprecated
    def pagecurl(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemPageCurl, action)
    end

    def page_curl(&action)
      sugarcube_barbuttonitem(UIBarButtonSystemItemPageCurl, action)
    end

    def titled(title, style = UIBarButtonItemStyleBordered, &action)
      sugarcube_barbuttonitem_with_title(title, style, action)
    end

    def imaged(image, style = UIBarButtonItemStyleBordered, &action)
      sugarcube_barbuttonitem_with_image(image, style, action)
    end

  end

  # Adds the action and keeps a strong reference to the Proc object.
  def set_target_and_action target, action
    self.target = target
    self.action = 'sugarcube_handle_action:'
    @sugarcube_action = action.respond_to?('weak!') ? action.weak! : action
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
