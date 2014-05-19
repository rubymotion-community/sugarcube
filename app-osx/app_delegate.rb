class AppDelegate
  def applicationDidFinishLaunching(notification)
    app_name = NSBundle.mainBundle.infoDictionary['CFBundleName']

    main_menu = NSMenu.new
    menu = NSMenu.alloc.initWithTitle(app_name)
    menu.addItemWithTitle("Quit #{app_name}", action: 'terminate:', keyEquivalent: 'q')
    item = NSMenuItem.alloc.initWithTitle(app_name, action: nil, keyEquivalent: '')
    item.submenu = menu
    main_menu.addItem item

    NSApp.mainMenu = main_menu

    return if RUBYMOTION_ENV == 'test'

    @main_window = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @main_window.title = app_name
    @main_window.orderFrontRegardless
  end

end
