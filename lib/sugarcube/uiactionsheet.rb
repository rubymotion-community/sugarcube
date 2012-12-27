class UIActionSheet

  # UIActionSheet.alert("title",
  #   # The first button is considered the 'cancel' button, for the purposes of
  #   # whether the cancel or success handler gets called, the second button is
  #   # the 'destructive' button, and the rest are plain old buttons.
  #   buttons: %w"Cancel OK No-way",
  #   cancel: proc{ puts "nevermind" },
  #   destructive: proc{ puts "OHHH YEAAH!" },
  #   success: proc{ |pressed| puts "pressed: #{pressed}" },
  #   )
  def self.alert(title, options={}, &block)
    # create the delegate
    delegate = SugarCube::ActionSheetDelegate.new
    delegate.on_success = options[:success] || block
    delegate.on_destructive = options[:destructive]
    delegate.on_cancel = options[:cancel]
    delegate.send(:retain)

    args = [title]            # initWithTitle:
    args << delegate          # delegate:

    buttons = []
    buttons.concat(options[:buttons]) if options[:buttons]

    if buttons.empty?
      # cancelButtonTitle: is first, so check for cancel handler
      if options[:cancel]
        buttons << 'Cancel'
      else
        buttons << nil
      end

      # destructiveButtonTitle, check for destructive handler
      if options[:destructive]
        buttons << 'Delete'
      else
        buttons << nil
      end
    elsif buttons.length == 1 and (options[:cancel] or options[:destructive])
      raise 'If you only have one button, use a :success handler, not :cancel or :destructive'
    end

    # uses localized buttons in the actual alert
    if buttons.length == 0
      buttons = [nil, nil]
    elsif buttons.length == 1
      buttons << nil
    end

    last_index = buttons.length - 1
    offset = 0

    button_index_map = {}
    if buttons[1]  # destructive
      button_index_map[0] = buttons[1]
      offset += 1
    else
      last_index -= 1
    end

    if buttons[0]  # cancel
      button_index_map[last_index] = buttons[0]
    end

    buttons[2..-1].each_with_index { |button, index|
      button_index_map[index + offset] = button
    }
    # the button titles, mapped to how UIActionSheet orders them.  These are passed to the success handler.
    delegate.button_index_map = button_index_map

    args.concat(buttons.map{ |s| s ? s.localized : nil })
    args << nil  # otherButtonTitles:..., nil

    alert = self.alloc
    alert.send('initWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:', *args)
    window = UIApplication.sharedApplication.keyWindow || UIApplication.sharedApplication.windows[0]
    alert.showInView(window)
    alert
  end

  private
  def dummy
    self.initWithTitle(nil, delegate:nil, cancelButtonTitle:nil, destructiveButtonTitle:nil, otherButtonTitles:nil)
  end

end


module SugarCube
  class ActionSheetDelegate
    attr_accessor :button_index_map
    attr_accessor :on_cancel
    attr_accessor :on_destructive
    attr_accessor :on_success

    def actionSheet(alert, didDismissWithButtonIndex:index)
      if index == alert.destructiveButtonIndex && on_destructive
        on_destructive.call
      elsif index == alert.cancelButtonIndex && on_cancel
        on_cancel.call
      elsif on_success
        if on_success.arity == 0
          on_success.call
        else
          button = button_index_map[index]
          on_success.call(button)
        end
      end

      self.send(:autorelease)
    end

  end
end
