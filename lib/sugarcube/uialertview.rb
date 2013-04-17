class UIAlertView

  # UIAlertView.alert("title",
  #   message: "help!",
  #   # The first button is considered the 'cancel' button, for the purposes of
  #   # whether the cancel or success handler gets called
  #   buttons: %w"Cancel OK No-way",
  #   cancel: proc{ puts "nevermind" },
  #   success: proc{ |pressed| puts "pressed: #{pressed}" },
  #   )
  def self.alert(title, options={}, &block)
    if options.is_a? String
      options = {message: options}
    end

    # create the delegate
    delegate = SugarCube::AlertViewDelegate.new
    delegate.on_success = options[:success]
    delegate.on_cancel = options[:cancel]
    delegate.on_default = block
    delegate.send(:retain)

    args = [title]            # initWithTitle:
    args << options[:message] # message:
    args << delegate          # delegate:

    buttons = options[:buttons] || []
    if buttons.empty?
      # cancelButtonTitle: is first, so check for cancel
      if options[:cancel]
        buttons << "Cancel"
      end

      # otherButtonTitles:
      if buttons.empty?
        buttons << nil  # cancel button => nil
        buttons << "OK"  # other buttons => "OK"
      elsif options[:success]
        buttons << "OK"
      end
    elsif buttons.length == 1 && options[:cancel]
      raise "If you only have one button, use a :success handler, not :cancel (and definitely not BOTH)"
    end

    # the button titles.  These are passed to the success handler.
    delegate.buttons = buttons

    # uses localized buttons in the actual alert
    args.concat(buttons.map { |m| m && m.localized })
    args << nil  # otherButtonTitles:..., nil

    alert = self.alloc
    alert.send(:"initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:", *args)
    alert.show
    alert
  end

  private
  def dummy
    self.initWithTitle(nil, message:nil, delegate:nil, cancelButtonTitle:nil, otherButtonTitles:nil)
  end

end


module SugarCube
  class AlertViewDelegate
    attr_accessor :buttons
    attr_accessor :on_cancel
    attr_accessor :on_success
    attr_accessor :on_default

    def alertView(alert, didDismissWithButtonIndex:index)
      cancel_handler = on_cancel || on_default
      success_handler = on_success || on_default
      handler = nil

      if index == alert.cancelButtonIndex
        handler = cancel_handler
      else
        handler = success_handler
      end

      if handler.arity == 0
        handler.call
      else
        button = buttons[index]
        handler.call(button)
      end

      self.send(:autorelease)
    end

  end
end
