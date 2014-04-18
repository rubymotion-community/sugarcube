class UIAlertView

  # @example
  #     UIAlertView.alert("title",
  #       message: "help!",
  #       # The first button is considered the 'cancel' button, for the purposes of
  #       # whether the cancel or success handler gets called
  #       buttons: %w"Cancel OK No-way",
  #       cancel: proc{ puts "nevermind" },
  #       success: proc{ |pressed| puts "pressed: #{pressed}" },
  #       )
  #
  # If you choose
  def self.alert(title, options={}, more_options={}, &block)
    if options.is_a? String
      more_options[:message] = options
      options = more_options
    end

    # The delegate gets retained here because UIAlertView#delegate is a weak
    # reference.  It's released in the delegate method
    # `#didDismissWithButtonIndex(index)`
    delegate = SugarCube::AlertViewDelegate.new
    delegate.on_success = options[:success]
    delegate.on_cancel = options[:cancel]
    delegate.on_default = block
    delegate.send(:retain)

    args = [title]            # initWithTitle:
    args << options[:message] # message:
    args << delegate          # delegate:

    buttons = (options[:buttons] || []).freeze
    if buttons.empty?
      buttons = []  # an empty Hash becomes an Array

      # cancelButtonTitle: is first, so check for cancel
      if options[:cancel]
        buttons << "Cancel"
      end

      # otherButtonTitles:
      if buttons.empty?
        args << nil  # cancel button => nil
        buttons << "OK"  # other buttons => "OK"
      elsif options[:success]
        buttons << "OK"
      end
    elsif buttons.is_a?(Hash)

    elsif buttons.length == 1 && options[:cancel]
      raise "If you only have one button, use a :success handler, not :cancel (and definitely not BOTH)"
    end

    # the button titles.  These are passed to the success handler.
    if buttons.is_a?(Hash)
      button_titles = buttons.keys
    else
      button_titles = buttons
    end
    delegate.buttons = button_titles

    # uses localized buttons in the actual alert
    if buttons.is_a?(Hash)
      if buttons.key?(:cancel)
        args << (buttons[:cancel] && buttons[:cancel].localized)
      else
        args << nil
      end
      args.concat(buttons.select { |k, m| k != :cancel }.map { |k, m| m && m.localized })
    else
      args.concat(buttons.map { |m| m && m.localized })
    end
    args << nil  # otherButtonTitles:..., nil

    alert = self.alloc
    alert.send("initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:", *args)
    if options.key?(:style)
      style = options[:style]
      style = style.uialertstyle if style.respond_to?(:uialertstyle)
      alert.alertViewStyle = style
    end
    if options.fetch(:show, true)
      alert.show
    end
    alert
  end

  def <<(title)
    addButtonWithTitle(title)
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
      handler = nil
      if index == alert.cancelButtonIndex
        handler = on_cancel
      else
        handler = on_success
      end
      handler ||= on_default

      args = nil
      if handler
        if handler.arity == 0
          args = []
        else
          # construct all the possible arguments you could send
          args = [buttons[index]]
          # add the first input if this is not the default
          if alert.alertViewStyle != UIAlertViewStyleDefault
            args << alert.textFieldAtIndex(0).text
          end
          # add the second one if this is a login+password input
          if alert.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput
            args << alert.textFieldAtIndex(1).text
          end

          # and maybe you want the index, too
          args << index

          # but only send the ones they asked for
          args = args[0...handler.arity]
        end
        handler.call(*args)
      end

      self.send(:autorelease)
    end

  end
end
