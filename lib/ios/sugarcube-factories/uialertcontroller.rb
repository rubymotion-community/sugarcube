class UIAlertController
  attr_accessor :sugarcube_handler

  # @example
  #     UIAlertController.alert(controller, "title",
  #       message: "help!",
  #       buttons: %w"Cancel OK No-way"
  #       ) { |pressed| } # pressed will be Cancel OK No-way
  def self.alert(controller, title, options={}, more_options={}, &block)
    if title.is_a?(NSDictionary)
      options = title
      title   = options[:title]
      message = options[:message]
    elsif options.is_a?(String)
      message = options
      options = more_options
    else
      message = options[:message]
    end

    style = options[:style] || UIAlertControllerStyleAlert
    style = style.uialertcontrollerstyle if style.respond_to?(:uialertcontrollerstyle)

    alert = self.alertControllerWithTitle(title, message: message, preferredStyle: style)

    buttons = options[:buttons]
    if buttons.nil?
      buttons = %w(OK Cancel)
    end

    if block
      alert.sugarcube_handler = SugarCube::UIAlertControllerCallbackHelper.new(block)
    end

    if buttons.is_a?(NSDictionary)
      button_keys = buttons.keys
      buttons = buttons.values
    else
      button_keys = buttons
    end
    buttons.each_with_index do |button, index|
      key = button_keys[index]
      case key
        when :cancel, 'Cancel'
          action_style = UIAlertActionStyleCancel
          button = 'Cancel' if button == :cancel
        when :destructive, 'Destructive'
          action_style = UIAlertActionStyleDestructive
          button = 'Destructive' if button == :destructive
        else
          action_style = UIAlertActionStyleDefault
      end
      label = NSBundle.mainBundle.localizedStringForKey(button, value: nil, table: nil)
      action = UIAlertAction.actionWithTitle(label,
                                             style:   action_style,
                                             handler: proc { |_|
                                               alert.sugarcube_handler.call(key) unless alert.sugarcube_handler.nil?
                                             })
      alert.addAction action
    end

    if style == UIAlertControllerStyleActionSheet and UIDevice.currentDevice.userInterfaceIdiom == :ipad.uidevice
      alert.modalPresentationStyle = UIModalPresentationPopover
      alert.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny

      from = options.fetch(:from, UIApplication.sharedApplication.windows[0])
      case from
        when CGRect
          view                                           = options.fetch(:view, UIApplication.sharedApplication.windows[0])
          alert.popoverPresentationController.sourceView = view
          alert.popoverPresentationController.sourceRect = from
        when UIBarButtonItem
          alert.popoverPresentationController.barButtonItem = from
        when UIView
          frame                                          = [[CGRectGetMidX(from.bounds), CGRectGetMidY(from.bounds)], [1.0, 1.0]]
          alert.popoverPresentationController.sourceView = from
          alert.popoverPresentationController.sourceRect = frame
        else
          raise "Unknown :from option #{from.inspect}"
      end
    end

    if options.fetch(:show, true)
      controller.presentViewController(alert, animated: true, completion: nil)
    end

    alert
  end

  def <<(title)
    action = UIAlertAction.actionWithTitle(title,
                                           style:   UIAlertActionStyleDefault,
                                           handler: proc { |_|
                                             sugarcube_handler.call(title) unless sugarcube_handler.nil?
                                           })
    addAction action
  end
end

module SugarCube
  class UIAlertControllerCallbackHelper

    def initialize(callback)
      @callback = callback.respond_to?('weak!') ? callback.weak! : callback
    end

    def call(button)
      @callback.call(button)
    end
  end
end
