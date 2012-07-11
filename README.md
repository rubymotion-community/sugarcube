sugarcube
=========

Some sugar for your cocoa, or your tea.

About
-----

CocoaTouch/iOS is a *verbose* framework.  These extensions hope to make
development in rubymotion more enjoyable by tacking "UI" methods onto the base
classes (String, Fixnum, Float).  With sugarcube, you can create a color from an
integer or symbol, or create a UIFont or UIImage from a string.

Some UI classes are opened up as well, like adding the '<<' operator to a UIView
instance, instead of view.addSubview(subview), you can use the more idiomatic:
view << subview.

The basic idea of sugarcube is to turn some operations on their head.  Insead of

    NSUIApplication.sharedApplication.openURL(NSUrl.URLWithString(url))

How about:

    url.nsurl.open

**DISCLAIMER**

It is possible that you *will not like sugarcube*.  That is perfectly fine!
Some people take milk in their coffee, some take sugar.  Some crazy maniacs
don't even *drink* coffee, if you can imagine that... All I'm saying is: to each
their own.  You should checkout [BubbleWrap][] for another take on
Cocoa-wrappage.

Examples
========

 Fixnum
--------

```ruby
# create a UIColor from a hex value
0xffffff.uicolor # => UIColor.colorWithRed(1.0, green:1.0, blue:1.0, alpha:1.0)
0xffffff.uicolor(0.5) # => UIColor.colorWithRed(1.0, green:1.0, blue:1.0, alpha:0.5)

# create a percentage
100.percent # => 1.00
55.percent # => 0.55
```

 Float
-------

```ruby
# create a percentage
100.0.percent # => 1.00
55.0.percent # => 0.55
```

 String
--------

```ruby
# UIImage from name
"my_image".uiimage # => UIImage.imageNamed("my_image")
# (if you have an image named "blue", use "blue".uiimage.uicolor)

# UIFont from name
"my_font".uifont # => UIFont.fontWithName("my_font", size:UIFont.systemFontSize)
"my_font".uifont(20) # => UIFont.fontWithName("my_font", size:20)

# UIColor from color name OR image name OR hex code
"blue".uicolor == :blue.uicolor # => UIColor.blueColor
"#ff00ff".uicolor == :fuchsia.uicolor == 0xff00ff.uicolor # => UIColor.colorWithRed(1.0, green:0.0, blue:1.0, alpha:1.0)
"#f0f".uicolor(0.5) == :fuchsia.uicolor(0.5) == 0xff00ff.uicolor(0.5) # => UIColor.colorWithRed(1.0, green:1.0, blue:1.0, alpha:0.5)
# note: 0xf0f.uicolor == 0x00f0f.uicolor.  There's no way to tell the difference
# at run time between those two Fixnum literals.
"my_image".uicolor == "my_image".uiimage.uicolor # => UIColor.colorWithPatternImage(UIImage.imageNamed("my_image"))

# NSLocalizedString from string
"hello".localized  # => NSBundle.mainBundle.localizedStringForKey("hello", value:nil, table:nil)
"hello".localized('Hello!', 'hello_table')  # => ...("hello", value:'Hello!', table:'hello_table')
```

 Symbol
--------

This is the "big daddy".  Lots of sugar here...

```ruby
:center.uialignment  # => UITextAlignmentCenter
:upside_down.uiorientation  # => UIDeviceOrientationPortraitUpsideDown
:rounded.uibuttontype  # => UIButtonTypeRoundedRect
:highlighted.uicontrolstate  # => UIControlStateHighlighted
:touch.uicontrolevent  # => UIControlEventTouchUpInside
:all.uicontrolevent  # => UIControlEventAllEvents
:blue.uicolor  # UIColor.blueColor
# all CSS colors are supported, and alpha
# (no "grey"s, only "gray"s, consistent with UIKit, which only provides "grayColor")
:firebrick.uicolor(0.25)  # => 0xb22222.uicolor(0.25)
:bold.uifont  # UIFont.boldSystemFontOfSize(UIFont.systemFontSize)
:bold.uifont(10)  # UIFont.boldSystemFontOfSize(10)
:small.uifontsize # => UIFont.smallSystemFontSize
:small.uifont  # => UIFont.systemFontOfSize(:small.uifontsize)
:bold.uifont(:small)  # UIFont.boldSystemFontOfSize(:small.uifontsize)
```

 UIImage
---------

```ruby
image = "my_image".uiimage
image.uicolor # => UIColor.colorWithPatternImage(image)
```

 UIView
--------

```ruby
self.view << subview  # => self.view.addSubview(subview)
```

 UIControl
-----------

Inspired by [BubbleWrap's][BubbleWrap] `when` method, but I prefer jQuery-style
verbs and sugarcube symbols.

```ruby
button = UIButton.alloc.initWithFrame([0, 0, 10, 10])

button.on(:touch) { my_code }
button.on(:touchupoutside, :touchcancel) { |event|
  puts event.inspect
  # my_code...
}

# remove handlers
button.off(:touch, :touchupoutside, :touchcancel)
button.off(:all)
```

You can only remove handlers by "type", not by the action.  e.g. If you bind
three `:touch` events, calling `button.off(:touch)` will remove all three.

[BubbleWrap]: https://github.com/rubymotion/BubbleWrap
