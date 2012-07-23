sugarcube
=========

Some sugar for your cocoa, or your [tea][sweettea].

About
-----

CocoaTouch/iOS is a *verbose* framework.  These extensions hope to make
development in rubymotion more enjoyable by tacking "UI" methods onto the base
classes (String, Fixnum, Numeric).  With sugarcube, you can create a color from an
integer or symbol, or create a UIFont or UIImage from a string.

Some UI classes are opened up as well, like adding the '<<' operator to a UIView
instance, instead of view.addSubview(subview), you can use the more idiomatic:
view << subview.

The basic idea of sugarcube is to turn some operations on their head.  Insead of

    UIApplication.sharedApplication.openURL(NSUrl.URLWithString(url))

How about:

    url.nsurl.open

**DISCLAIMER**

It is possible that you *will not like sugarcube*.  That is perfectly fine!
Some people take milk in their coffee, some take sugar.  Some crazy maniacs
don't even *drink* coffee, if you can imagine that... All I'm saying is: to each
their own.  You should checkout [BubbleWrap][] for another take on
Cocoa-wrappage.

Installation
============

    gem install sugarcube

    # or in Gemfile
    gem 'sugarcube'

    # in Rakefile
    require 'sugarcube'

Examples
========

 Fixnum
--------

```ruby
# create a UIColor from a hex value
0xffffff.uicolor # => UIColor.colorWithRed(1.0, green:1.0, blue:1.0, alpha:1.0)
0xffffff.uicolor(0.5) # => UIColor.colorWithRed(1.0, green:1.0, blue:1.0, alpha:0.5)
```

 Numeric
---------

```ruby
# create a percentage
100.0.percent # => 1.00
55.0.percent # => 0.55

1.3.seconds.later do
  @someview.fade_out
end
```

 NSURL
-------

```ruby
# see String for easy URL creation
"https://github.com".nsurl.open  # => UIApplication.sharedApplication.openURL(NSURL.URLWithString("https://github.com"))
```

 NSString
----------

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
"hello"._          # == "hello".localized
"hello".localized('Hello!', 'hello_table')  # => ...("hello", value:'Hello!', table:'hello_table')

# file location
"my.plist".exists?   # => NSFileManager.defaultManager.fileExistsAtPath("my.plist")
"my.plist".document  # => NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0].stringByAppendingPathComponent("my.plist")

# NSURL
"https://github.com".nsurl  # => NSURL.URLWithString("https://github.com")
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
:large.uiactivityindicatorstyle  # :large, :white, :gray
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
self.view.show  # => self.hidden = false
self.view.hide  # => self.hidden = true
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

 UINavigationController
------------------------

`push`/`<<` and `pop` instead of `pushViewController` and `popViewController`.
`!` and `!(view)` instead of `popToRootViewController` and `popToViewController`

animated is `true` for all these.

```ruby
nav_ctlr.push(new_ctlr)
nav_ctlr << new_ctlr
nav_ctlr.pop
nav_ctlr.!
nav_ctlr.!(another_view_ctlr)
```

 NSNotificationCenter
----------------------

Makes it easy to post a notification to some or all objects.

```ruby
# this one is handy, I think:
"my notification".post_notification  # => NSNotificationCenter.defaultCenter.postNotificationName("my notification", object:nil)
"my notification".post_notification(obj)  # => NSNotificationCenter.defaultCenter.postNotificationName("my notification", object:obj)
"my notification".post_notification(obj, user: 'dict')  # => NSNotificationCenter.defaultCenter.postNotificationName("my notification", object:obj, userInfo:{user: 'dict'})
```

 NSTimer
---------

```ruby
1.second.later do
  @view.shake
end
```

 NSUserDefaults
----------------

```ruby
'key'.set_default(['any', 'objects'])  # => NSUserDefaults.standardUserDefaults.setObject(['any', 'objects'], forKey: :key)
'key'.get_default  # => NSUserDefaults.standardUserDefaults.objectForKey(:key)

# symbols are converted to strings, so theses are equivalent
:key.set_default(['any', 'objects'])  # => NSUserDefaults.standardUserDefaults.setObject(['any', 'objects'], forKey: :key)
:key.get_default  # => NSUserDefaults.standardUserDefaults.objectForKey(:key)
```

This is strange, and backwards, which is just sugarcube's style.  But there is
one advantage to doing it this way.  Compare these two snippets:

```ruby
# BubbleWrap
App::Persistance[:test] = { my: 'test' }
# sugarcube
:test.set_default { my: 'test' }
# k, BubbleWrap looks better

App::Persistance[:test][:my] == 'test'  # true
:test.get_default[:my]  # true, and odd looking - what's my point?

App::Persistance[:test][:my] = 'new'  # nothing is saved.  bug
:test.get_default[:my] = 'new'  # nothing is saved, but that's *obvious*

test = App::Persistance[:test]
test[:my] = 'new'
App::Persistance[:test] = test  # saved

test = :test.get_default
test[:my] = 'new'
:test.set_default test
```

 CoreGraphics
--------------

###### Is it `CGMakeRect` or `CGRectMake`?

Instead, just use `Rect`, `Size` and `Point`.  These are namespaced in
`SugarCube::CoreGraphics` module, but I recommend you `include
SugarCube::CoreGraphics` in app_delegate.rb.

```ruby
f = Rect(view.frame)  # converts a CGRect into a CGRectArray
o = Point(view.frame.origin)  # converts a CGPoint into a CGPointArray
s = Size(view.frame.size)  # converts a CGSize into a CGSizeArray

# lots of other conversions are possible.
# 4 numbers
f = Rect(x, y, w, h)
# or two arrays
p = Point(x, y)  # or just [x, y] works, too
s = Size(w, h)  # again, [w, h] is fine
f = Rect(p, s)
f = Rect([[x, y], [w, h]])  # same as above (the CG*Array objects will get created for you)

view.frame = f  # Rect returns a CGRectArray, which view.frame can accept
```

###### Animations

jQuery-like animation methods.

```ruby
# default timeout is 0.3
view.fade_out { |view|
  view.removeFromSuperview
}
# options:
view.fade_out(0.5, delay: 0,
                  options: UIViewAnimationOptionCurveLinear,
                  opacity: 0.5) { |view|
  view.removeFromSuperview
}

view.move_to([0, 100])  # move to position 0, 100
view.delta_to([0, 100])  # move over 0, down 100, from current position

view.slide :left   # slides the entire view one "page" to the left, right, up, or down

view.shake  # shakes the view.
# options w/ default values:
shake offset: 8,   # move 8 px left, and 8 px right
      repeat: 3,   # three times
    duration: 0.3, # for a total of 0.3 seconds
     keypath: 'transform.translate.x'

# vigorous nodding - modifying transform.translation.y:
view.shake offset: 20, repeat: 10, duration: 5, keypath: 'transform.translation.y'
# an adorable wiggle - modifying transform.rotation:
superview.shake offset: 0.1, repeat: 2, duration: 0.5, keypath: 'transform.rotation'
```

 REPL View adjustments
-----------------------

Pixel pushing is an unfortunate but necessary evil.  Well, at least we can make
it a little less painful.

These methods help you adjust the frame of a view.  They are in the
`SugarCube::Adjust` module so as not to conflict.  If you don't want the prefix,
`include SugarCube::Adjust` in app_delegate.rb

Assume I ran `include SugarCube::Adjust` in these examples.

```ruby
# if you are in the REPL, you might not be able to click on the view you want...
> adjust superview.subviews[4].subviews[1]
> up 1
> down 1  # same as up -1, obviously
> left 1
> right 1  # same as up -1, obviously
> origin 10, 12  # move to x:10, y:12
> wider 1
> thinner 1
> taller 1
> shorter 1
> size 100, 10  # set size to width:100, height: 10
> shadow(opacity: 0.5, offset: [0, 0], color: :black, radius: 1) # and path, which is a CGPath object.
> restore  # original frame and shadow is saved when you call `adjust`
```

```ruby
> # short versions!
> a superview.subviews[4].subviews[1]  # this is not uncommon in the REPL
> u          # up, default value=1
> d          # down
> l          # left
> r          # right
> o 10, 12   # origin, also accepts an array (or Point() object)
> w          # wider
> n          # thinner
> t          # taller
> s          # shorter
> z 100, 10  # size, also accepts an array (or Size() object)
> # you can also query your view.  You will get nice-looking
> # SugarCube::CoreGraphics objects
> f   # frame
[[0, 0], [320, 480]]
> o   # origin
[0, 0]
> z   # size
[320, 480]
> h   # shadow - this returns an array identical to what you can pass to `shadow`

# if you forget what view you are adjusting, run `adjust` again
> a
=> {UITextField @ x: 46.0 y:214.0, 280.0×33.0} child of UIView
```

[BubbleWrap]: https://github.com/rubymotion/BubbleWrap
[sweettea]: https://github.com/colinta/sweettea
