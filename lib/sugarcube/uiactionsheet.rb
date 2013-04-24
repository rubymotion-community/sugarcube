class UIActionSheet

  # For the purposes of whether the cancel or success handler gets called, the
  # first button is considered the 'cancel' button, the second button is the
  # 'destructive' button, and the rest are plain old buttons.
  #
  # If you use just one block, it will be used for *all* of the buttons.
  #
  # @example
  #     UIActionSheet.alert("title",
  #       buttons: %w"Cancel Delete No-way",
  #       cancel: proc{ puts "nevermind" },
  #       destructive: proc{ puts "OHHH YEAAH!" },
  #       success: proc{ |pressed| puts "pressed: #{pressed}" },
  #       )
  #     UIActionSheet.alert("title", buttons: [...]) { |button| }
  def self.alert(title, options={}, &block)
    # create the delegate
    delegate = SugarCube::ActionSheetDelegate.new
    delegate.on_default = block
    delegate.on_success = options[:success]
    delegate.on_destructive = options[:destructive]
    delegate.on_cancel = options[:cancel]
    delegate.send(:retain)

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

    buttons[2..-1].each_with_index do |button, index|
      button_index_map[index + offset] = button
    end
    # the button titles, mapped to how UIActionSheet orders them.  These are passed to the success handler.
    delegate.button_index_map = button_index_map

    args = [title]            # initWithTitle:
    args << delegate          # delegate:
    # cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:
    args.concat(buttons.map{ |s| s ? s.localized : nil })
    args << nil  # otherButtonTitles:..., nil

    alert = self.alloc
    alert.send('initWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:', *args)
    window = UIApplication.sharedApplication.windows[0]
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
    attr_accessor :on_default
    attr_accessor :on_cancel
    attr_accessor :on_destructive
    attr_accessor :on_success

    def actionSheet(alert, didDismissWithButtonIndex:index)
      handler = nil
      if index == alert.destructiveButtonIndex && on_destructive
        handler = on_destructive || on_default
      elsif index == alert.cancelButtonIndex && on_cancel
        handler = on_cancel || on_default
      else
        handler = on_success || on_default
      end

      if handler
        if handler.arity == 0
          handler.call
        else
          button = button_index_map[index]
          handler.call(button)
        end
      end

      self.send(:autorelease)
    end

  end
end
