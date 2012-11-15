class UIActionSheet

  # UIActionSheet.alert("message",
  #   # The first button is considered the 'cancel' button, for the purposes of
  #   # whether the cancel or success handler gets called, the second button is
  #   # the 'destructive' button, and the rest are plain old buttons.
  #   buttons: %w"Cancel OK No-way",
  #   cancel: proc{ puts "nevermind" },
  #   destructive: proc{ puts "OHHH YEAAH!" },
  #   success: proc{ |pressed| puts "pressed: #{pressed}" },
  #   )
  def self.alert(title, options={}, &block)
    if options.is_a? String
      options = {message: options}
    end

    # create the delegate
    delegate = SugarCube::ActionSheetDelegate.new
    delegate.on_success = options[:success] || block
    delegate.on_destructive = options[:destructive] || block
    delegate.on_cancel = options[:cancel]
    delegate.send(:retain)

    args = [title]            # initWithTitle:
    args << options[:message] # message:
    args << delegate          # delegate:

    buttons = options[:buttons] || []
    if buttons.empty?
      # cancelButtonTitle: is first, so check for cancel
      buttons << "Cancel" if options[:cancel]
      # destructiveButtonTitle: is first, so check for cancel
      buttons << "Cancel" if options[:cancel]
      # otherButtonTitles:
      buttons << "OK" if options[:success] or buttons.empty?
    elsif buttons.length == 1 and options[:cancel]
      raise "If you only have one button, use a :success handler, not :cancel (and definitely not BOTH)"
    end

    # the button titles.  These are passed to the success handler.
    delegate.buttons = buttons

    # uses localized buttons in the actual alert
    args.concat(buttons.map{ |s| s.localized })
    args << nil  # otherButtonTitles:..., nil

    alert = self.alloc
    alert.send('initWithTitle:message:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:', *args)
    alert.show
    alert
  end

  private
  def dummy
    self.initWithTitle(nil, message:nil, delegate:nil, cancelButtonTitle:nil, destructiveButtonTitle:nil, otherButtonTitles:nil)
  end

end


module SugarCube
  class ActionSheetDelegate
    attr_accessor :buttons
    attr_accessor :on_cancel
    attr_accessor :on_destructive
    attr_accessor :on_success

    def alertSheet(alert, didDismissWithButtonIndex:index)
      if index == alert.destructiveButtonIndex && on_destructive
        on_destructive.call
      elsif index == alert.cancelButtonIndex && on_cancel
        on_cancel.call
      elsif on_success
        if on_success.arity == 0
          on_success.call
        else
          button = buttons[index]
          on_success.call(button)
        end
      end

      self.send(:autorelease)
    end

  end
end
