class UIAlertController

  attr_accessor :handler

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
    elsif options.is_a? String
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

    alert.handler = SugarCube::UIAlertControllerCallbackHelper.new(block)

    buttons.each do |button|
      case button
        when :cancel, 'Cancel'
          action_style = UIAlertActionStyleCancel
          label        = NSBundle.mainBundle.localizedStringForKey('Cancel', value: nil, table: nil)
        when :destructive, 'Destructive'
          action_style = UIAlertActionStyleDestructive
          label        = NSBundle.mainBundle.localizedStringForKey('Destructive', value: nil, table: nil)
        else
          action_style = UIAlertActionStyleDefault
          label        = button
      end
      action = UIAlertAction.actionWithTitle(label,
                                             style:   action_style,
                                             handler: proc { |_|
                                               alert.handler.call(button)
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
                                             handler.call(title) unless block.nil?
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
