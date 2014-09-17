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
    if title.is_a?(NSDictionary)
      options = title
      title = options[:title]
    end

    # create the delegate
    delegate = SugarCube::ActionSheetDelegate.new
    delegate.on_default = block
    delegate.on_success = options[:success]
    delegate.on_destructive = options[:destructive]
    delegate.on_cancel = options[:cancel]
    delegate.send(:retain)

    args = [title]            # initWithTitle:
    args << delegate          # delegate:

    buttons = (options[:buttons] || []).freeze
    if buttons.empty?
      buttons = []  # an empty Hash becomes an Array

      # cancelButtonTitle:
      buttons << nil

      # destructiveButtonTitle
      buttons << nil

      # otherButtonTitles:
      buttons << 'OK'
    elsif buttons.length == 1 && (options[:cancel] || options[:destructive])
      raise 'If you only have one button, use a :success handler, not :cancel or :destructive'
    end

    # the button titles, mapped to how UIActionSheet orders them.  These are
    # passed to the success handler.
    buttons_mapped = {}

    # cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:
    # uses localized buttons in the actual alert
    if buttons.is_a?(NSDictionary)
      button_titles = buttons.keys
      if buttons.key?(:cancel)
        args << (buttons[:cancel] && NSBundle.mainBundle.localizedStringForKey(buttons[:cancel], value: nil, table: nil))
      else
        args << nil
      end
      if buttons.key?(:destructive)
        args << (buttons[:destructive] && NSBundle.mainBundle.localizedStringForKey(buttons[:destructive], value: nil, table: nil))
      else
        args << nil
      end
      args.concat(buttons.select { |k, m| k != :cancel && k != :destructive }.map { |k, m| m && NSBundle.mainBundle.localizedStringForKey(m, value: nil, table: nil) })
    else
      button_titles = buttons
      args.concat(buttons.map { |m| m && NSBundle.mainBundle.localizedStringForKey(m, value: nil, table: nil) })
    end
    args << nil  # otherButtonTitles:..., nil

    if args[2] && args[3]  # cancel && destructive buttons
      buttons_mapped[0] = button_titles[1]                   # destructiveIndex == 0, button == 1
      buttons_mapped[button_titles.length - 1] = button_titles[0]  # cancelIndex == last, button == 0
      # from first+1 to last-1
      button_titles[2..-1].each_with_index do |button,index|
        buttons_mapped[index + 1] = button
      end
    elsif args[3]  # destructive button
      buttons_mapped[0] = button_titles[1]                   # destructiveIndex == 0, button == 1
      # from first+1 to last-1
      buttons[2..-1].each_with_index do |button,index|
        buttons_mapped[index + 1] = button
      end
    elsif args[2]  # cancel button
      buttons_mapped[buttons.length - 2] = button_titles[0]  # cancelIndex == last, button == 0
      button_titles[2..-1].each_with_index do |button,index|
        buttons_mapped[index] = button
      end
    else
      button_titles[2..-1].each_with_index do |button,index|
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
        view = options.fetch(:view, UIApplication.sharedApplication.windows[0])
        alert.showFromRect(from, inView: view, animated: true)
      when UIBarButtonItem
        alert.showFromBarButtonItem(from, animated: true)
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

    def actionSheet(alert, didDismissWithButtonIndex: index)
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
        else
          button = buttons[index]

          if handler.arity == 1
            handler.call(button)
          else
            handler.call(button, index)
          end
        end
      end

      self.send(:autorelease)
    end

  end
end
