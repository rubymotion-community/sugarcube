class UIActionSheet

  # For the purposes of whether the cancel or success handler gets called, the
  # first button is considered the 'cancel' button, the second button is the
  # 'destructive' button, and the rest are plain old buttons.
  #
  # If you use just one block, it will be used for *all* of the buttons.
  #
  # @example
  #     # use a different handler for each button type
  #     UIActionSheet.alert("title",
  #       buttons: %w"Cancel Delete No-way",
  #       cancel: proc{ puts "nevermind" },
  #       destructive: proc{ puts "OHHH YEAAH!" },
  #       success: proc{ |pressed| puts "pressed: #{pressed}" },
  #       )
  #     # use one handler for all buttons
  #     UIActionSheet.alert("title", buttons: [...]) { |button| }
  def self.alert(title, options={}, &block)
    # create the delegate
    delegate = SugarCube::ActionSheetDelegate.new
    delegate.on_default = block
    delegate.on_success = options[:success]
    delegate.on_destructive = options[:destructive]
    delegate.on_cancel = options[:cancel]
    delegate.send(:retain)

    args = [title]            # initWithTitle:
    args << delegate          # delegate:

    buttons = []
    buttons.concat(options[:buttons]) if options[:buttons]

    if buttons.empty?
      # cancelButtonTitle:
      buttons << nil

      # destructiveButtonTitle
      buttons << nil

      # otherButtonTitles:
      buttons << 'OK'
    elsif buttons.length == 1 && (options[:cancel] || options[:destructive])
      raise 'If you only have one button, use a :success handler, not :cancel or :destructive'
    end

    # cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:
    args.concat(buttons.map{ |s| s ? s.localized : nil })
    args << nil  # otherButtonTitles:..., nil

    # the button titles, mapped to how UIActionSheet orders them.  These are
    # passed to the success handler.
    buttons_mapped = {}
    if args[2] && args[3]  # cancel && destructive buttons
      buttons_mapped[0] = buttons[1]                   # destructiveIndex == 0, button == 1
      buttons_mapped[buttons.length - 1] = buttons[0]  # cancelIndex == last, button == 0
      # from first+1 to last-1
      buttons[2..-1].each_with_index do |button,index|
        buttons_mapped[index + 1] = button
      end
    elsif args[3]  # destructive button
      buttons_mapped[0] = buttons[1]                   # destructiveIndex == 0, button == 1
      # from first+1 to last-1
      buttons[2..-1].each_with_index do |button,index|
        buttons_mapped[index + 1] = button
      end
    elsif args[2]  # cancel button
      buttons_mapped[buttons.length - 2] = buttons[0]  # cancelIndex == last, button == 0
      buttons[2..-1].each_with_index do |button,index|
        buttons_mapped[index] = button
      end
    else
      buttons[2..-1].each_with_index do |button,index|
        buttons_mapped[index] = button
      end
    end
    delegate.buttons = buttons_mapped

    alert = self.alloc
    alert.send('initWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:', *args)

    if options.key?(:style)
      style = options[:style]
      if style.respond_to?(:uiactionstyle)
        style = style.uiactionstyle
      end
      alert.actionSheetStyle = style
    end

    if options.fetch(:show, true)
      if options.key?(:from)
        from = options[:from]
      else
        from = UIApplication.sharedApplication.windows[0]
      end

      case from
      when CGRect
        view = UIApplication.sharedApplication.windows[0]
        alert.showFromRect(from, inView: view, animated: true)
      when UIBarButtonItem
        alert.showFromBarButtonItem(from)
      when UIToolbar
        alert.showFromToolbar(from)
      when UITabBar
        alert.showFromTabBar(from)
      when UIView
        alert.showInView(from)
      else
        raise "Unknown :from option #{from.inspect}"
      end
    end

    alert
  end

  def <<(title)
    addButtonWithTitle(title)
  end

  private
  def dummy
    self.initWithTitle(nil, delegate:nil, cancelButtonTitle:nil, destructiveButtonTitle:nil, otherButtonTitles:nil)
  end

end


module SugarCube
  class ActionSheetDelegate
    attr_accessor :buttons
    attr_accessor :on_default
    attr_accessor :on_cancel
    attr_accessor :on_destructive
    attr_accessor :on_success

    def actionSheet(alert, didDismissWithButtonIndex:index)
      handler = nil
      if index == alert.destructiveButtonIndex && on_destructive
        handler = on_destructive
      elsif index == alert.cancelButtonIndex && on_cancel
        handler = on_cancel
      elsif index != alert.destructiveButtonIndex && index != alert.cancelButtonIndex && on_success
        handler = on_success
      end
      handler ||= on_default

      if handler
        if handler.arity == 0
          handler.call
        elsif handler.arity == 1
          button = buttons[index]
          handler.call(button)
        else
          button = buttons[index]
          handler.call(button, index)
        end
      end

      self.send(:autorelease)
    end

  end
end
