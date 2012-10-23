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
    delegate.on_success = options[:success] || block
    delegate.on_cancel = options[:cancel]
    delegate.send(:retain)

    args = [title]            # initWithTitle:
    args << options[:message] # message:
    args << delegate          # delegate:

    buttons = options[:buttons] || []
    if buttons.empty?
      # cancelButtonTitle: is first, so check for cancel
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

    def alertView(alert, didDismissWithButtonIndex:index)
      if index == 0 && on_cancel
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
