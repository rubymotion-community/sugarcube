class AppDelegate
  def applicationDidFinishLaunching(notification)
    return true if RUBYMOTION_ENV == 'test'

    main_menu = NSMenu.new
    NSApp.mainMenu = main_menu

    appName = NSBundle.mainBundle.infoDictionary['CFBundleName']

    menu = NSMenu.alloc.initWithTitle(appName)
    menu.addItemWithTitle("Quit #{appName}", action: 'terminate:', keyEquivalent: 'q')
    item = NSMenuItem.alloc.initWithTitle(appName, action: nil, keyEquivalent: '')
    item.submenu = menu
    main_menu.addItem item

    main_window = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    main_window.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    main_window.orderFrontRegardless
  end

end
