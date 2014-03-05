SugarCube
=========

Some sugar for your [cocoa](http://rubymotion.com), or your [tea][sweettea].

[![Build Status](https://travis-ci.org/rubymotion/sugarcube.png)](https://travis-ci.org/rubymotion/sugarcube)

About
-----

CocoaTouch/iOS is a *verbose* framework.  These extensions hope to make
development in rubymotion more enjoyable. With SugarCube, you can create a color
from an integer or symbol, or create a UIFont or UIImage from a string.

Some core classes are opened up as well, like adding the '<<' operator to a
UIView instance, instead of view.addSubview(subview), you can use the more
idiomatic: view << subview.

The basic idea of SugarCube is to turn operations on their head.  So instead of:

    UIApplication.sharedApplication.openURL(NSURL.URLWithString(url))

How about:

    url.nsurl.open

**DISCLAIMER**

It is possible that you *will not like SugarCube*.  That is perfectly fine!
Some people take milk in their coffee, some take sugar.  Some crazy maniacs
don't even *drink* coffee, if you can imagine that... All I'm saying is: to each
their own.  You should checkout [BubbleWrap][] for another take on
Cocoa-wrappage.

**CONTRIBUTIONS**

SugarCube started out as a [Fusionbox][] project (see the
[announcement][fusionbox announcement]), but as its popularity increased, the
decision was made to offer it to the rubymotion community, in the spirit of
open-source and collaboration.  It is a great complement to [teacup][],
especially when paired with [sweettea][]!

Documentation
=============

A work in progress.  This README is the best source, but I am trying to be more
diligent about adding Yard documentation, which is available here:

<http://rubydoc.info/gems/sugarcube/latest>

[documentation]: http://rubydoc.info/gems/sugarcube/latest

Installation
============

    gem install sugarcube

    # in Rakefile
    require 'sugarcube'

    # or in Gemfile
    gem 'sugarcube', :require => 'sugarcube-classic'
    # or for the bold:
    # gem 'sugarcube', :require => 'sugarcube-all'
    # or for the picky:
    # gem 'sugarcube', :require => [
    #   'sugarcube',
    #   'sugarcube-repl',
    # ]

    # in terminal
    $ bundle install

Packages
========

SugarCube has grown over time to be a pretty massive collection of helpers.
While some people choose to use the entire library, other people like to pick
and choose the extensions they want to use.  With that in mind, SugarCube is
written so that it does *not* pollute any classes by default.  So if all you do
is `require "sugarcube"`, you are NOT going to get much mileage!

In the installation code above, I show the example of using `:require => 'sugarcube-all'`
to include *all* of SugarCube's extensions.  Usually you will require the
packages you need from your Rakefile:

```ruby
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'
require 'bundler'
Bundler.require
require './lib/sugarcube-uikit'
require './lib/sugarcube-events'
require './lib/sugarcube-gestures'
require './lib/sugarcube-568'
require './lib/sugarcube-attributedstring'
# ...
```

You can require the packages in piecemeal like this, or you can require a group
of packages: `classic, common, or all`.

* `sugarcube-classic`: Excludes **568**, **attributedstring**, **gestures**, **repl**, **awesome**, **anonymous**, **unholy**, and **legacy**
* `sugarcube-common`: Excludes **awesome**, **anonymous**, **unholy**, and **legacy**
* `sugarcube-all`: Excludes **legacy**

So without further ado,

SugarCube
=========

Packages are sorted more-or-less by their usefulness.  The more esoteric ones
are at the end.

REPL ([wiki][REPL Wiki])
----

If you install SugarCube and *only* use the REPL package, you will benefit from
some of its greatest tools!

> `require 'sugarcube-repl'`

This package is useful during development because it adds methods to the REPL
that make adjusting and introspecting views much easier.  You'll get a lot more
done in the REPL with these additions.

To keep this document lean-and-mean, I've put most of the REPL documentation [in
the wiki][REPL Wiki], but a
quick overview:

* Use the `tree` commands to output your view hierarchy.  It can accept a UIView,
  `UIViewController`, or `CALayer` object as the root object, or it defaults to
  your application's `UIWindow` object.

  ```
  (main)> tree
    0: . UIWindow(#6e1f950: [[0.0, 0.0], [320.0, 480.0]])
    1: `-- UIView(#8b203b0: [[0.0, 20.0], [320.0, 460.0]])
    2:     +-- UIButton(#d028de0: [[10.0, 10.0], [320.0, 463.400512695312]])
  ```
* The number can be passed to the `adjust` method, aliased to `a`, and that will
  become the view or object you are adjusting.

  ```
  (main)> a 2
  => UIButton(#d028de0: [[10.0, 10.0], [320.0, 463.400512695312]])
  ```

* Now you can modify that view, either by accessing it via `a` (with no
  arguments it returns the object being adjusted) or by using an adjust method:

  ```
  > up 1
  > wider 15
  # these have shorthands, too
  > u 1
  > w 15
  ```

Be sure to read more in the [REPL Additions][REPL Wiki] Wiki page.

[REPL Wiki]: https://github.com/rubymotion/sugarcube/wiki/REPL-Additions

UIKit ([wiki][UIKit Wiki])
-----

A big package chock full of methods to make working in UIKit a joy.

> `require 'sugarcube-uikit'`

A few varieties of methods are in this package:

* Conversions: `'string-to'.uiimage`, `image.uiimageview`
* Helpers: shorthands for common operations, like `a_view << a_subview`, `a_subview.convert_frame_to(a_view)`
* Symbols: `:system.uifont(20)`, `:label.uifontsize`
* Frame accessors: `a_view.x`, `a_view.x = 100`

There are too many methods to define here. Instead: a complete list of methods
is available in the [documentation][], and the [wiki page][UIKit Wiki] is a
great source as well.

[UIKit Wiki]: https://github.com/rubymotion/sugarcube/wiki/UIKit

Constants
-----

> `require 'sugarcube-constants'`

There are lots and lots of constants in UIKit, so many that I wanted a way to
write these as symbols instead of UILongConstantNames.  This package adds
methods to `Symbol`s to convert them into a UIKit or Foundation constant.

```ruby
:center.uialignment  # => UITextAlignmentCenter
:upside_down.uiorientation  # => UIDeviceOrientationPortraitUpsideDown
:rounded.uibuttontype  # => UIButtonTypeRoundedRect
:highlighted.uicontrolstate  # => UIControlStateHighlighted
:touch.uicontrolevent  # => UIControlEventTouchUpInside
:change.uicontrolevent  # => UIControlEventValueChanged
:all.uicontrolevent  # => UIControlEventAllEvents

# these are really handy for custom buttons - touch_start means the finger is
# inside the button, touch_stop is outside the button or canceled
:touch_start  # => UIControlEventTouchDown | UIControlEventTouchDragEnter
:touch_stop   # => UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchDragExit

:large.uiactivityindicatorstyle  # :large, :white, :gray
:bar.uisegmentedstyle   # :plain, :bordered, :bar, :bezeled

# UITableView and UITableViewCell have LOTS of associated constants... I'm
# adding them as I come across them.
:automatic.uitablerowanimation   # or .uitableviewrowanimation
:default.uitablecellstyle        # or .uitableviewcellstyle
:disclosure.uitablecellaccessory  # or .uitableviewcellaccessorytype
:blue.uitablecellselectionstyle  # or .uitableviewcellselectionstyle
```

See the complete list by browsing the [documentation][], or open up [symbol.rb][].

[symbol.rb]: https://github.com/rubymotion/sugarcube/blob/master/lib/sugarcube-constants/symbol.rb

Timer
-----

> `require 'sugarcube-timer'`

Methods get added to the Fixnum class, and are available as methods on
`NSTimer`, *and* can be called via the SugarCube::Timer module.

```ruby
# once
1.second.later do
  @view.shake
end
# repeating
1.second.every do
  @view.shake
end

# you can assign the return value (an NSTimer)
timer = 1.second.every do
  @view.shake
end
# and invalidate it
timer.invalidate

# the `every` method is available in the SugarCube::Timer module,
# which you might find more readable
include SugarCube::Timer

every 1.minute do
  puts "tick"
end

# might as well make an alias for 'later', too
after 1.minute do
  puts "ding!"
end

# other time-related methods
# for compatibility with Time methods, the mins/secs (and min/sec) aliases are provided.  Personally,
# I like the more verbose minutes/seconds.
1.millisecond  || 2.milliseconds
1.millisec     || 2.millisecs
1.second  || 2.seconds
1.sec     || 2.secs     # aliases
1.minute  || 2.minutes  # 1.minute = 60 seconds
1.min     || 2.mins     # aliases
1.hour    || 2.hours    # 1.hour = 60 minutes
1.day     || 2.days     # 1.day = 24 hours
1.week    || 2.weeks    # 1.week = 7 days
# sensible values for 'month' and 'year', even though we all know you can't
# **really** define them this way (go back to python if you find your brain hemorrhaging):
1.month   || 2.months   # 1.month = 30 days
1.year    || 2.years    # 1.year = 365 days
```

Events
-----

> `require 'sugarcube-events'`

Inspired by [BubbleWrap's][BubbleWrap] `when` method, but I prefer jQuery-style
verbs and SugarCube symbols.  Adds methods to UIControl and UITextView.

UIControl
-----------

```ruby
button = UIButton.alloc.initWithFrame([[0, 0] ,[10, 10]])

button.on(:touch) { my_code }
button.on(:touch_up_outside, :touch_cancel) { |event|
  puts event.inspect
  # my_code...
}

# remove handlers
button.off(:touch, :touch_up_outside, :touch_cancel)
button.off(:all)
```

You can only remove handlers by "type", not by the action.  e.g. If you bind
three `:touch` events, calling `button.off(:touch)` will remove all three.

UITextView
------------

These handlers are functionally identical in usage to the same methods in
`UIControl`.  They use the `NSNotificationCenter#addObserverForName:object:queue:usingBlock:`
method, but you do not have to worry about un-observing.  When the text view is
released, these observers will be removed.

There are two aliases for each event, or you can use the event notification. I
prefer the present tense (jQuery-style `on :change`), but UIKit prefers past
simple (`:editing_did_begin`).  The notifications, on the other hand, are in
present simple (`UITextViewTextDidBeginEditingNotification`).  Whatever floats
your boat.

Anyway, these are all the same:

    :editing_did_begin   :begin   UITextViewTextDidBeginEditingNotification
    :editing_did_change  :change  UITextViewTextDidChangeNotification
    :editing_did_end     :end     UITextViewTextDidEndEditingNotification

```ruby
text_view = UITextView.new
text_view.on :begin do |notification|  # <= you have to accept the notification in your block
  p 'wait for it...'
end
text_view.on :change do |notification|
  p text_view.text
end
text_view.on :end do |notification|
  p 'done!'
end

# if you want to remove the block, use the off method
text_view.off :editing_did_change
# or
text_view.off :change
# or
text_view.off UITextViewTextDidChangeNotification
```

Gestures
-----

> `require 'sugarcube-gestures'`

SugarCube's gesture support is very similar to BubbleWrap's, and it's entirely
possible that the two will be merged into one thing.  But SugarCube is all about
extending base classes, whereas BubbleWrap tends to add *new* classes to do the
heavy lifting.  Plus the options you pass to SugarCube are very different, and
the prefix is "on" instead of "when" (e.g. "on_pan" instead of "when_panned")

```ruby
view.on_pan do |gesture|
  location = gesture.view.locationInView(view)
end

# other gesture methods, with common options:
view.on_tap   # use system defaults
view.on_tap(1)  # number of taps
view.on_tap(taps: 1, fingers: 1)  # number of taps and number of fingers

view.on_pinch   # no options
view.on_rotate  # no options

view.on_swipe   # use system defaults
view.on_swipe :left
view.on_swipe(direction: :left, fingers: 1)
view.on_swipe(direction: UISwipeGestureRecognizerDirectionLeft, fingers: 1)

view.on_pan   # use system defaults
view.on_pan(2)  # minimum and maximum fingers required
view.on_pan(fingers: 2)
view.on_pan(min_fingers: 2, max_fingers: 3)

# `on_press` is a continuous event (it uses UILongPressGestureRecognizer), so
# you need to check the `gesture`:
view.on_press do |gesture|
  if gesture.state == UIGestureRecognizerStateBegan
    # handle press
  end
end
view.on_press(1.5)  # duration
view.on_press(duration: 1.5, taps: 1, fingers: 1)

# this version is only fired when the long-press begins; this is *probably* more
# useful to you:
view.on_press_begin do ... end
```

Notifications
-----

> `require 'sugarcube-notifications'`

Makes it easy to post a notification to some or all objects.

```ruby
# this one is handy, I think:
MyNotification = "my notification"
MyNotification.post_notification  # => NSNotificationCenter.defaultCenter.postNotificationName(MyNotification, object:nil)
MyNotification.post_notification(obj)  # => NSNotificationCenter.defaultCenter.postNotificationName(MyNotification, object:obj)
MyNotification.post_notification(obj, user: 'dict')  # => NSNotificationCenter.defaultCenter.postNotificationName(MyNotification, object:obj, userInfo:{user: 'dict'})

# you can access the userInfo dictionary directly from the notification
def notified(notification)
  notification[:user]  # => 'dict'
end

# very similar to add or remove an observer
MyNotification.add_observer(observer, :method_name)
MyNotification.add_observer(observer, :method_name, object)

# remove the observer
MyNotification.remove_observer(observer)
MyNotification.remove_observer(observer, object)
```

UIImage
-----

Image Manipulation - VERY handy!  Includes some quick maniputions on UIImage,
and adds an interface to chain together CIFilters.  Plus, you can refer to
`cifilter.rb` to find out what filters are supported in iOS (all supported
filters get a class method in this file).

> `require 'sugarcube-image'`

###### UIImage additions
```ruby
image.scale_to [37, 37]
image.rounded  # default: 5 pt radius
image.rounded(10)

image.in_rect([[10, 10], [100, 100]])  # get part of an image

image.darken  # => good for "pressed" buttons
image.darken(brightness: -0.5, saturation: -0.2)  # these are the defaults

image.rotate(:left)
image.rotate(:right)
image.rotate(:flip)  # 180° - if you have a better name, let me know!
image.rotate(45.degrees)

image.in_rect(frame)  # returns the part of the image contained in frame
image.scale_to(new_size)  # won't stretch, but the image might have transparent padding
image.scale_to(new_size, background: :white)  # adds a white background before padding
image.scale_within(new_size)  # same as scale_to in that it doesn't stretch the
# image, but the size is not guaranteed to be new_size.  It is guaranteed not to
# be *bigger* than new_size
image.scale_to_fill(new_size)  # again, like scale_to, but the image is guaranteed
# to completely fill new_size, even if some of the image has to be cropped to fit.
# You can control which side or corner you prefer to remain visible.  because the
# aspect ratio is maintained, only ONE dimension will need to be cropped.
image.scale_to_fill(new_size, position: :top_left)

# returns a UIColor (and supports retina images)
image.color_at([5, 5])

# default insets are UIEdgeInsetsZero
image.tileable
image.tileable(insets)
image.stretchable
image.stretchable(insets)

# Apply a mask to an image.  The mask should be a grayscale image.  White areas
# will be made transparent, and black opaque.
image.masked(mask_image)

# Apply a color overlay to an image. This is used used on icons (PNG's), on which
# you want to change the color.
image.overlay(UIColor.redColor)
image.overlay(:red)

# Combine two images
image_ab = image_a << image_b

# Create an image from scratch!
UIImage.canvas([100, 100]) do |context|  # opaque: false, scale: UIScreen.mainScreen.scale
  # draw here!
end

# use an image as a background to draw on
image.draw do |context|
  # draw here!
end

# size
image = Image.canvas(size: [10, 20])
image.width  # => 10
image.height  # => 20
```

###### CIFilter additions
```ruby
# create a filter
gaussy = CIFilter.gaussian_blur(radius: 5)
gaussy = CIFilter.gaussian_blur(5)  # this also works - you can find the arg order by looking in cifilter.rb

# apply a filter to a UIImage
new_image = image.apply_filter(gaussy).uiimage  # apply_filter returns a CIImage, which is converted to UIImage

# apply a chain of filters using the `|` operator or `apply_filter`
darken = CIFilter.color_controls(saturation: 0, brightness: 0)
new_image = image.apply_filter(gaussy).apply_filter(darken).uiimage
```

If you include `sugarcube-pipes` you can use the `|` operator to chain filters:

```ruby
# using the filters from above
new_image = image | gaussy | darken | UIImage
new_view = view | gaussy | darken | UIView
```

There are 91 filters available in iOS 6, I won't list them here, but check out
[the Apple documentation][core-image-filters] to read about them, and study
[cifilter.rb][].

[core-image-filters]: http://developer.apple.com/library/mac/#documentation/GraphicsImaging/Reference/CoreImageFilterReference/Reference/reference.html
[cifilter.rb]: https://github.com/colinta/sugarcube/blob/1.0/lib/sugarcube-image/cifilter.rb
[cifilter.rb-post-merge]: https://github.com/rubymotion/sugarcube/blob/master/lib/sugarcube-image/cifilter.rb

UIColor
-----

> `require 'sugarcube-color'`

Methods to merge or manipulate a color, or to get information about a color.
Works best on RGB colors, but HSB will work well, too.  `UIColor`s based on
image patterns can't easily be inverted or mixed.

Any classes that have a well-defined "color" representation are given a
`uicolor` method, so it's easy to create a color from hex codes, css names,
or images (as patterns).

```ruby
:blue.uicolor  # UIColor.blueColor
# uicolor() accepts an alpha value, too
:blue.uicolor(0.5)

# all CSS colors are supported (but no "grey" aliases, consistent with UIKit,
# which only provides "grayColor")
:firebrick.uicolor  # => 0xb22222.uicolor

# RGB values, in the range 0..255.
[160, 210, 242].uicolor  # => UIColor.colorWithRed(0.6274, green:0.8235, blue:0.9490, alpha:1.0)
[160, 210, 242].uicolor(0.5)  # => UIColor.colorWithRed(0.6274, green:0.8235, blue:0.9490, alpha:0.5)

# create a UIColor from a hex value
0xffffff.uicolor # => UIColor.colorWithRed(1.0, green:1.0, blue:1.0, alpha:1.0)
0xffffff.uicolor(0.5) # => UIColor.colorWithRed(1.0, green:1.0, blue:1.0, alpha:0.5)

# works when using strings, too
"#fff".uicolor # => UIColor.whiteColor
"#ffffff".uicolor # => UIColor.whiteColor
"#ff00ff".uicolor == :fuchsia.uicolor == 0xff00ff.uicolor # => UIColor.colorWithRed(1.0, green:0.0, blue:1.0, alpha:1.0)
"#f0f".uicolor(0.5) == :fuchsia.uicolor(0.5) == 0xff00ff.uicolor(0.5) # => UIColor.colorWithRed(1.0, green:1.0, blue:1.0, alpha:0.5)

# note: 0xf0f.uicolor == 0x000f0f.uicolor.  There's no way to tell the difference
# at run time between those two Fixnum literals.

# UIColor from image name, if the first character is not "#"
"pattern".uicolor == "pattern".uiimage.uicolor  # => UIColor.colorWithPatternImage(UIImage.imageNamed("pattern"))
```

These methods are added onto the UIColor class:

```ruby
:red.uicolor.invert # => UIColor.cyanColor
:blue.uicolor.invert # => UIColor.yellowColor
:green.uicolor.invert # => UIColor.magentaColor
:red.uicolor + :blue.uicolor # => UIColor.purpleColor
:red.uicolor + :green.uicolor # => :olive.uicolor
# (I didn't know that until I tried it in the REPL, but it was pretty cool to
# see the UIColor#to_s method match that mixture to olive!)

# a more generic color mixing method (`+` delegates to this method):
:white.uicolor.mix_with(:black.uicolor, 0)  # => :white
:white.uicolor.mix_with(:black.uicolor, 0.25)  # => 0x404040.uicolor
:white.uicolor.mix_with(:black.uicolor, 0.5)  # => :gray, same as :white.uicolor + :black.uicolor
:white.uicolor.mix_with(:black.uicolor, 0.75)  # => 0xbfbfbf.uicolor
:white.uicolor.mix_with(:black.uicolor, 1)  # => :black

# you can get information about a color:
:cyan.uicolor.red         # => 0
:cyan.uicolor.green       # => 1
:cyan.uicolor.blue        # => 1
:cyan.uicolor.hue         # => 0.5
:cyan.uicolor.saturation  # => 1.0
:cyan.uicolor.brightness  # => 1.0
:cyan.uicolor(0.9).alpha  # => 0.9

# convert to CGColor
color.cgcolor
```

Factories
-----

> `require 'sugarcube-factories'`

###### UIAlertView

Accepts multiple buttons and handlers.  In its simplest form, you can pass just
a title and block.

```ruby
# simple
UIAlertView.alert "This is happening, OK?" { self.happened! }

# a little more complex - the cancel button should be first, and the block will
# receive a string, not an index
UIAlertView.alert("This is happening, OK?", buttons: ["Nevermind", "OK"],
  message: "Don't worry, it'll be fine.") { |button|
  if button == "OK"
    self.happened!
  end
}

# Full on whiz-bangery.  The cancel button should be the first entry in
# `buttons:`.  When you specify the success and cancel button handlers this way,
# you need not assign both.
UIAlertView.alert "I mean, is this cool?", buttons: %w[No! Sure! Hmmmm],
  message: "No going back now",
  cancel: proc { self.cancel },
  success: proc { |pressed| self.proceed if pressed == "Sure!" }
```

###### UIActionSheet

This is very similar to `UIAlertView.alert`, but instead of `cancel` and
`success` handlers, you can have `cancel, success, and destructive` handlers,
and there is no `message` argument.

If you use an array of buttons (which you probably *should*), the order of
arguments is `[:cancel, :destructive, :others, ...]`.  If you *dont* want a
cancel or destructive button, pass `nil` in place.

```ruby
# simple
UIActionSheet.alert 'This is happening, OK?' { self.happened! }
# a little more complex, with cancel and destructive buttons
UIActionSheet.alert('This is happening, OK?', buttons: ['Sure!', 'OK']
  ) {
  self.happened!
}

UIActionSheet.alert('Should I?', buttons: [nil, nil, 'OK', 'Nevermind']) { |pressed|
  self.do_it if pressed == 'OK'
}

UIActionSheet.alert 'I mean, is this cool?', buttons: ['Nah', 'With fire!', 'Sure', 'whatever'],
  cancel: proc { self.cancel },
  destructive: proc { self.kill_it_with_fire }
  success: proc { |pressed| self.proceed if pressed == 'Sure' }
```

###### UIButton
```ruby
UIButton.buttonWithType(:custom.uibuttontype)
# =>
UIButton.custom

UIButton.custom            => UIButton.buttonWithType(:custom.uibuttontype)
UIButton.rounded           => UIButton.buttonWithType(:rounded.uibuttontype)
UIButton.rounded_rect      => UIButton.buttonWithType(:rounded_rect.uibuttontype)
UIButton.detail            => UIButton.buttonWithType(:detail.uibuttontype)
UIButton.detail_disclosure => UIButton.buttonWithType(:detail_disclosure.uibuttontype)
UIButton.info              => UIButton.buttonWithType(:info.uibuttontype)
UIButton.info_light        => UIButton.buttonWithType(:info_light.uibuttontype)
UIButton.info_dark         => UIButton.buttonWithType(:info_dark.uibuttontype)
UIButton.contact           => UIButton.buttonWithType(:contact.uibuttontype)
UIButton.contact_add       => UIButton.buttonWithType(:contact_add.uibuttontype)
UIButton.system            => UIButton.buttonWithType(:system.uibuttontype)
```

###### UITableView

Default frame is `[[0, 0], [0, 0]]`, but most containers will resize it to be
the correct size.  But heads up, it *was* `[[0, 0], [320, 480]]` (until
the iphone 5 / 4-inch retina came out).

```ruby
UITableView.alloc.initWithFrame([[0, 0], [0, 0]], style: :plain.uitableviewstyle)
UITableView.alloc.initWithFrame([[0, 0], [320, 480]], style: :plain.uitableviewstyle)
UITableView.alloc.initWithFrame([[0, 0], [320, 568]], style: :plain.uitableviewstyle)
# custom frame:
UITableView.alloc.initWithFrame([[0, 0], [320, 400]], style: :grouped.uitableviewstyle)

# =>
UITableView.plain
UITableView.plain([[0, 0], [320, 480]])
UITableView.plain([[0, 0], [320, 568]])
# custom frame:
UITableView.grouped([[0, 0], [320, 400]])
```

###### UITableViewCell

```ruby
# factory methods, named for the cell style. cell identifier is required.
UITableViewCell.default('cell_identifier')
UITableViewCell.value1('cell_identifier')
UITableViewCell.value2('cell_identifier')
UITableViewCell.subtitle('cell_identifier')

# you can options for the common settings
cell = UITableViewCell.default('cell_identifier',
  accessory: :disclosure,
  selection: :blue,
  text: 'text',
  image: 'icon', # coerced into a UIImage
  )
```

###### UISegmentedControl

```ruby
control = UISegmentedControl.alloc.initItems(["one", "ah-two-whoo", "thr-r-r-ree"])
control.segmentedControlStyle = :bar.uisegmentedstyle

# =>

UISegmentedControl.bar(["one", "ah-two-whoo", "thr-r-r-ree"])
# plain, bordered, and bezeled are the other types
```

###### UIActivityViewIndicator

```ruby
UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhite)
UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhiteLarge)
UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)

# =>

UIActivityIndicatorView.white
UIActivityIndicatorView.large
UIActivityIndicatorView.gray
```

###### UIBarButtonItem

These factory methods accept a block, which will get wired up as a
target/action.

```ruby
# Get an instance containing the specified system item.
UIBarButtonItem.done do
  self.dismissViewControllerAnimated true, completion:nil
end
# =>
UIBarButtonItem.alloc.initWithBarButtonSystemItem(:done.uibarbuttonitem, target:self, action:"action:")
# with 'action' defined as:
def action(sender)
  self.dismissViewControllerAnimated true, completion:nil
end

# the method names are 1::1 with the uibarbuttonitem constants in symbol.rb
UIBarButtonItem.cancel { ... }           => UIBarButtonItem.alloc.initWithBarButtonSystemItem(:cancel.uibarbuttonitem, target:self, action:"action:")
UIBarButtonItem.edit { ... }             => UIBarButtonItem.alloc.initWithBarButtonSystemItem(:edit.uibarbuttonitem, target:self, action:"action:")
UIBarButtonItem.save { ... }             => UIBarButtonItem.alloc.initWithBarButtonSystemItem(:save.uibarbuttonitem, target:self, action:"action:")
  .
  .
  .
UIBarButtonItem.page_curl { ... }         => UIBarButtonItem.alloc.initWithBarButtonSystemItem(:page_curl.uibarbuttonitem, target:self, action:"action:")
```

For custom `UIBarButtonItem`s, you can use the `titled` and `imaged` methods:

```ruby
# Create a UIBarButtonItem, specifying the title
UIBarButtonItem.titled('Close') do
  self.dismissViewControllerAnimated(true, completion:nil)
end
# =>
UIBarButtonItem.alloc.initWithTitle('Close', style: :bordered.uibarbuttonstyle, target:self, action:"action:")
def action(sender)
  self.dismissViewControllerAnimated(true, completion:nil)
end


# You can also specify the style.
UIBarButtonItem.titled('Close', :plain) do  # :plain, :bordered, :done
  # ...
end

# Or specify the image instead
UIBarButtonItem.imaged('close_icon') do  # 'close_icon' will be coerced into a UIImage
  # ...
end
# =>
UIBarButtonItem.alloc.initWithImage('Close'.uiimage, style: :bordered.uibarbuttonstyle, ...)

# And, like `titled`, specify the style
UIBarButtonItem.imaged('close'.uiimage, :done) do
  # ...
end

# If you provide two images, they will be used as the portrait and landscape images
UIBarButtonItem.imaged(['portrait'.uiimage, 'landscape'.uiimage) do
  # ...
end
# =>
UIBarButtonItem.alloc.initWithImage('portrait'.uiimage, landscapeImagePhone:'landscape'.uiimage, style: :bordered.uibarbuttonstyle, target:self, action:"action:")
```

Example Usage:
```ruby
toolbar = UIToolbar.new
toolbar.items = [
  @image_picker_button = UIBarButtonItem.camera { presentImagePickerController(self) },
  UIBarButtonItem.flexiblespace,
  @saveButton = UIBarButtonItem.save { save_photo(self) }
]
```

###### UITabBarItem

Easy to create system or custom `UITabBarItem`s.

```ruby
UITabBarItem.titled('My Title')
# with optional :image and :selected_image options:
UITabBarItem.titled('My Title', image: 'my_icon', selected_image: 'my_icon_selected')
# also supports :tag and :badge
UITabBarItem.titled('My Title', tag: MY_TABBAR_ITEM, badge: '+1')

# system items:
UITabBarItem.more
UITabBarItem.favorites

# Most of the UITabBarItem init methods accept the UIView#tag, and so there is
# support for that in the UITabBarItem factory methods.  Defaults to 0.  The
# :badge option is supported here as well
UITabBarItem.featured(tag: MY_TABBAR_ITEM, badge: 10)

# All of the UITabBarSystemItem helpers delegate to the 'UITabBarItem.system'
# method, which you can call direcly as well.  It accepts :tag and :badge
# options.
UITabBarItem.system(:top_rated, tag: MY_ITEM_TAG, badge: 'hi')
```

###### NSError
```ruby
# usually, NSError.new doesn't work, because the only initializer for NSError
# needs more arguments.  This method passes some defaults in.
NSError.new('message')
# same as =>
NSError.new('message', domain: 'Error', code: 0, userInfo: {})
```

Animations ([wiki][Animations Wiki])
-----

> `require 'sugarcube-animations'`

Careful, once you start using these helpers, you'll never go back.

```ruby
view.move_to [100.0, 100.0] # origin
view.center_to [100.0, 100.0] # center
view.scale_to 2  # double the size, and preserves existing rotation transform
# view.scale_to 4 -> CGAffineTransformMakeScale(4, 4)
# view.scale_to [4, 3] -> CGAffineTransformMakeScale(4, 3)
view.fade_out
view.slide :left, 100
view.rotate_to 180.degrees
view.shake  # great for showing invalid form elements
view.tumble  # great way to dismiss an alert-like-view
# tumbles in the other direction (towards the right side instead of left)
view.tumble(side: :right)

# the complement to 'tumble' is 'tumble_in' - the view starts above the window
# and drops in with the same kind of animation as 'tumble'.  Before you call
# this method, set the view.frame to the *destination* location.
view.tumble_in(side: :right)
```

These helpers all delegate to the `UIView.animate` method, which accepts all the
options that `UIView.animateWithDuration(delay:options:animations:completion:)`
or `UIView.animateWithDuration(delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:)`
accept.  All options are optional, and they will play nicely inside an animation
chain (see below, and the wiki page).

```ruby
UIView.animate do
  view.alpha = 0
end
```

The "spring" animations use the method `UIView.animateWithDuration(delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:)`,
available in iOS 7.  In testing, I've found this method to be slightly
unreliable, so use with caution.  To "enable" it, pass in the `:damping` option.
You can also use `:velocity` to set an initial velocity, if there is an
animation in progress.

```ruby
new_frame = [[110, 200], [100, 20]]

UIView.animate(damping: 0.1) do  # default velocity is 0
  view.frame = new_frame
end

# equivalent:
view.reframe_to(new_frame, damping: 0.1, velocity: 1)
```

The [wiki] page documents all the different animation methods, and documents
animation chaining, which looks like this:

```ruby
# fade out and slide left, then fade back in while returning to original position
UIView.animation_chain do
  view.fade_out
  view.slide :left
end.and_then do
  view.fade_in
  view.slide :right
end.start
```

Core Animation classes get some love, too!

```ruby
view.layer.basic_animation('opacity', from: 0, to: 1, duration: 0.1)
```

Lots more information in the Wiki!

[Animations Wiki]: https://github.com/rubymotion/sugarcube/wiki/Animations

Modal
-----

> `require 'sugarcube-modal'`

It is nice that *any* `UIViewController` can present a modal, but if you have
tabs or navs or crap in the way, this is actually *NOT* what you want.  You
should use the `rootViewController` (whatever it may be) to present to modal.

And since this is a property on `UIWindow`, which is more-or-less a constant, we
can make this the easiest to do!

```ruby
include SugarCube::Modal  # make these methods available globally

view_ctlr = EditSomethingViewController.new
present_modal(view_ctlr)
# ...later, when all is well...
dismiss_modal
```

These accept completion blocks:

```ruby
present_modal(view_ctlr) { puts "Now You See Me!" }
dismiss_modal { puts "Now You Don't!" }
```

If you like these methods, but you want to specify the reciever, they are
re-defined on `UIViewController` for this purpose:

```ruby
controller.present_modal(other_controller) { puts "presented" }
```

Numbers
-----

> `require 'sugarcube-numbers'`

### Converting input

Uses `NSNumberFormatter` to try and parse a human-readable number string.

```ruby
if input.nan?
  UIAlertView.alert('not a number!')
else
  number = input.to_number
end
```

### Pretty print numbers

Use NSNumberFormatter to easily format a number in the current locale

```ruby
10000.string_with_style  # => "10,000"
10000.string_with_style(NSNumberFormatterCurrencyStyle)  # => "$10,000.00"
# will convert symbol-constants using the sugarcube-constants package, if it is available
10000.string_with_style(:currency)  # => "$10,000.00"
```

### Percent

```ruby
100.0.percent # => 1.00
55.0.percent # => 0.55
```

### Ordinals

```ruby
# some number-to-string stuff
1.nth  # => 'st'
2.nth  # => 'nd'
3.nth  # => 'rd'
4.nth  # => 'th'
11.nth  # => 'th'
13.nth  # => 'th'
21.nth  # => 'st'
23.nth  # => 'rd'
```

### Angles

Since you always want to work in radians, calling `10.degrees` returns 10°, *in
radians*.  You can convert back to degrees using `to_degrees`.  Lastly, you can
specify a multiple of π as a number:

```ruby
10.degrees  # => π / 18
45.degrees  # => π / 4
3.14159.to_degrees  # => approx 180
2.pi  # => 6.28318...
```

### Distances

If you thought conversion from degrees to radians looks weird, you'll hate
conversion from meters to miles:

```ruby
distance = 1500  # this is in meters.  why?  because all the methods that return
                 # a "distance" return it in meters
distance = 2.miles  # => 3218.688, that's how many meters are in 2 miles
1500.in_miles  # converts meters to miles => 0.932056427001953
```

### Sizes

Similar conversion methods for hard disk sizes.  Uses the "mebi-byte" concepts,
e.g. 1024 bytes in a kilobyte.

```ruby
1.byte      # => 1
1.kilobyte  # => 1024
1.megabyte  # => 1048576
1.gigabyte  # => 1073741824
1.terabyte  # => 1099511627776
1.petabyte  # => 1125899906842624
1.exabyte   # => 1152921504606846976

1.megabyte.in_kilobytes   # => 1024
```

### Screen

```ruby
1.pixel  # => 1 on non-retina, 0.5 on retina.
         # Useful when drawing if you want to specify the number of pixels
```

AttributedString
-----

> `require 'sugarcube-attributedstring'`

These are pretty fun!  Check out [nsattributedstring_spec.rb][] for all the
supported attributes (in theory they are all supported, but there's weird
issues with missing constants).

[nsattributedstring.rb]: https://github.com/rubymotion/sugarcube/blob/master/lib/sugarcube-attributedstring/nsattributedstring.rb

```ruby
'test'.nsattributedstring({})  #=> NSAttributedString.alloc.initWithString('test', attributes:{})
'test'.attrd  # => alias for `nsattributedstring`
'test'.bold  # => NSAttributedString.alloc.initWithString('test', attributes:{NSFontAttributeName => :bold.uifont})
'test'.italic  # => NSAttributedString.alloc.initWithString('test', attributes:{NSFontAttributeName => :italic.uifont})
'test'.underline  # => NSAttributedString.alloc.initWithString('test', attributes:{NSUnderlineStyleAttributeName => NSUnderlineStyleSingle})

# you can chain 'em, too.
'test'.bold.underline
# If you look up NSAttributedString Application Kit Additions, you can see all
# the constants.  Each of those has a method on NSAttributedString.

# you can add 'em, but the FIRST one MUST be an NSAttributedString
'test'.attrd + '-ing'.italic

# And there's where it gets FUN:
('This'.italic + ' is going to be ' + 'FUN'.bold).underline
```

And you can easily turn an attributed string into a label, if you include the
`sugarcube-uikit` package.

```ruby
view << (("We just met\n".attrd +
          "and this is " + "CRAZY".italic + "\n"
          "But here's my " + "id_rsa.pub".monospace + " file,\n" +
          "so give me SSH access.").uilabel
```

568
-----

> `require 'sugarcube-568'`

If you `require 'sugarcube-568'` in your Rakefile, you can use
`UIImage.imageNamed(name)` or `name.uiimage` to load images that are specific to
the 4" iphone.

```ruby
'tall'.uiimage  # => UIImage.imageNamed('tall')
# => tall.png on iphone 3g
# => tall@2x.png on iphone 4
# => tall-568h@2x.png on iphone 5
```

This code is ported from <https://github.com/gaj/imageNamed568>, which I had
some problems with on RubyMotion (it worked, but not *always*.  Very strange).

Files
-----

Methods to find document files, resource files, cache files, temporary files, and to access
entries out of the Info.plist file.

> `require 'sugarcube-files'`

```ruby
# file operations
"my.plist".file_exists?   # => NSFileManager.defaultManager.fileExistsAtPath("my.plist")

"my.plist".remove_file!  # => NSFileManager.defaultManager.removeItemAtPath("my.plist".document, error: error)  (returns error, if any occurred)

"my.plist".document_path  # => NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0].stringByAppendingPathComponent("my.plist")
"my.plist".cache_path  # => NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)[0].stringByAppendingPathComponent("my.plist")
"my.plist".temporary_path  # => NSTemporaryDirectory().stringByAppendingPathComponent("my.plist")

# all of these can be turned into a URL, too
"my.plist".temporary_path.file_url  # => NSURL.fileURLWithPath("my.plist".temporary_path)

# get the resource path, useful if you include json files or images you manipulate in the app
"my.plist".resource_path  # => NSBundle.mainBundle.resourcePath.stringByAppendingPathComponent("my.plist")
# same, but get a URL instead - often used to display a static HTML page that is stored in resources.
# getting a path URL from a resource is just a little different from creating a URL from any other type of path
"index.html".resource_url  # => NSBundle.mainBundle.URLForResource("index", withExtension:"html")

# access data from Info.plist
"CFBundleVersion".info_plist  # => NSBundle.mainBundle.infoDictionary["CFBundleVersion"]
```

Localized
-----

> `require 'sugarcube-localized'`

```ruby
# NSLocalizedString from string
"hello".localized  # => NSBundle.mainBundle.localizedStringForKey("hello", value:nil, table:nil)
"hello"._          # == "hello".localized
"hello".localized('Hello!', 'hello_table')  # => ...("hello", value:'Hello!', table:'hello_table')

# If you have an NSError object, you can retrieve the localizedDescription the same way:
error.localized
error._
```

NSCoder
-----

Shorthands and hash-like access to the coder/decoder objects.

> `require 'sugarcube-nscoder'`

```ruby
# hash access is the handiest
coder['key'] = self.value
self.value = decoder['key']

# but if you want to store booleans and such (in their C form,
# which will take up less space):
coder.set('sugarcube_is_neat', toBool: self.sugarcube_is_neat?)
self.sugarcube_is_neat = decoder.bool('sugarcube_is_neat')

coder.set('number_of_things', toInt:self.number_of_things)
self.number_of_things = decoder.int('number_of_things')

# the entire list:
coder.set(key, toBool:value)
coder.set(key, toDouble:value)
coder.set(key, toFloat:value)
coder.set(key, toInt:value)
coder.set(key, toPoint:value)
coder.set(key, toRect:value)
coder.set(key, toSize:value)

decoder.bool(key)
decoder.double(key)
decoder.float(key)
decoder.int(key)
decoder.point(key)
decoder.rect(key)
decoder.size(key)
```

NSData
-----

> `require 'sugarcube-nsdata'`

Going to and from `NSData` is really useful when doing HTTP posts.

```ruby
# default string encoding is UTF8, you can pass other encodings to this method
string_data = 'String'.nsdata

# PNG data representation
image = 'an image'.uiimage
image_data = image.nsdata

# this will download the URL contents
url = 'http://localhost'.nsurl
url.nsdata  # => NSData.dataWithContentsOfURL(self)

string_data.nsstring  # => 'String'
image_data.uiimage  # => whatever 'an image' was
```

NSDate ([wiki][NSDate Wiki])
-----

> `require 'sugarcube-nsdate'`

This package includes additions to the `NSDate` class, and related additions to
`Numeric` and `NSString`.  There's a lot here, so check out the [wiki][NSDate
Wiki] for detailed information.

[NSDate Wiki]: https://github.com/rubymotion/sugarcube/wiki/NSDate

Foundation
-----

Smaller additions to the CoreFoundation classes.  Some extensions, like
`NSDate`, are large enough that they get broken out into their own packages.

> `require 'sugarcube-foundation'`

###### NSArray
```ruby
[1, 3].nsindexpath  # NSIndexPath.indexPathWithIndex(1).indexPathByAddingIndex(3)
[1, 3].nsindexset
[1, 3].nsset
```

###### NSIndexSet
```ruby
index_set.to_a  # => [1, 2, ...]
```

###### NSIndexPath
```ruby
index_path.to_a  # => [1, 2, ...]
```

###### NSString
```ruby
'https://github.com'.nsurl
'/path/to/file'.fileurl
'https://google.com/search?q=' + 'search terms'.escape_url  # => "..?q=search%20terms"
'%20'.unescape_url  #=> " "
'nô àccénts!'.remove_accents  # => "no accents!"
```

###### NSURL
```ruby
url = 'https://github.com'.nsurl
url.can_open?  # => true, it will open in safari
url.open  # opens in safari
url.nsurlrequest  # convert to NSURLRequest object
```

IndexPath
-----

> `require 'sugarcube-indexpath`

Use the `IndexPath` class to match `NSIndexPath` objects, for instance in a
`UITableViewDelegate`.

```ruby
index_path = [0, 2].nsindexpath
case index_path
when IndexPath[0]
when IndexPath[1, 0..5]
when IndexPath[1, 5..objects.length]
end
[0, 2].nsindexpath.to_a == [0, 2]  # => true
```

NSUserDefaults
-----

> `require 'sugarcube-nsuserdefaults'`

This file does *one* thing very **DANGEROUS**... to "help" with defaults.

When storing `nil` into `NSUserDefaults`, it is converted into `false`, because
Cocoa complains if you give it `nil`, and the RubyMotion runtime refuses to
allow the `NSNull.null` object. Without relying on an external project (like
[nsnulldammit][] I don't know of a sensible workaround...

If you want to "tap into" the defaults system that SugarCube uses, add a
`to_nsuserdefaults` method and that will get called if you hand your object to
`NSUserDefaults[]=`.  However, there's no way to get it *back* later, so the
usefulness of this is very limited.

```ruby
NSUserDefaults['key'] = ['any', 'objects']  # => NSUserDefaults.standardUserDefaults.setObject(['any', 'objects'], forKey: :key)
NSUserDefaults['key']  # => NSUserDefaults.standardUserDefaults.objectForKey(:key)

# symbols are converted to strings, so these are equivalent
NSUserDefaults[:key] = ['any', 'objects']  # => NSUserDefaults.standardUserDefaults.setObject(['any', 'objects'], forKey: :key)
NSUserDefaults[:key]  # => NSUserDefaults.standardUserDefaults.objectForKey(:key)
```

Keep in mind that NSUserDefaults serializes the object you pass to it, it
doesn't maintain a reference.  That means that if you modify an object *in
place*, it will not get persisted.  An example will explain this better:

```ruby
NSUserDefaults['test'] = { my: 'test' }
NSUserDefaults['test']['my'] == 'test'
# NSUserDefaults['test'] returns the hash, and the 'my' key returns 'test', so
# this comparison returns `true`

# but there is a temptation, perhaps, to modify that hash:
NSUserDefaults['test']['my'] = 'new'  # BUG

# the corrected code
test = NSUserDefaults['test']
test['my'] = 'new'
NSUserDefaults['test'] = test  # saved
```

CoreGraphics
--------------

*This package is installed automatically, because so many other packages depend
on it. It does not add any methods to built-in classes.*

###### Is it `CGMakeRect` or `CGRectMake`?  What arguments does `CGRect.new` take?

Instead, just use the coercion methods `Rect()`, `Size()` and `Point()`.  They
will happily convert most sensible (and some non-sensible) arguments into a
`CGRect/CGSize/CGPoint` struct.

These are namespaced in the `SugarCube::CoreGraphics` module, but I recommend
you `include SugarCube::CoreGraphics` in app_delegate.rb.

For more CoreGraphics additions, you should use [geomotion][] by [Clay
Allsopp][].  It adds methods to `CGRect`, `CGPoint`, and `CGSize` to make these
structures more rubyesque (these methods used to be part of SugarCube, but were
removed in an attempt to decrease the amount of duplicated code).

```ruby
f = Rect(view.frame)  # the identity function - returns a copy of the CGRect
o = Point(view.frame.origin)  # returns a copy of CGPoint
s = Size(view.frame.size)  # returns a copy of CGSize

# lots of other conversions are possible.
# a UIView or CALayer => view.frame
f = Rect(view)
# 4 numbers
f = Rect(x, y, w, h)
# or two arrays
f = Rect([x, y], [w, h])
# one array
f = Rect([[x, y], [w, h]])
# a CGPoint and CGSize
p = Point(x, y)  # or just [x, y] works, too
s = Size(w, h)  # again, [w, h] is fine
f = Rect(p, s)
# any combination of point/array and size/array
f = Rect(p, [w, h])
f = Rect([x, y], s)
```

Pointer
-----

> `require 'sugarcube-pointer'`

These are not UIKit-related, so I reverted to Ruby's preferred `to_foo`
convention.

```ruby
[0.0, 1.1, 2.2].to_pointer(:float)

# is equivalent to
floats = Pointer.new(:float, 3)
floats[0] = 0.0
floats[1] = 1.1
floats[2] = 2.2
```

To_s
-----

> `require 'sugarcube-to_s'`

`to_s` methods are defined on the following classes:

* NSError
* NSIndexPath
* NSLayoutConstraint
* NSNotification
* NSSet
* NSURL
* UIColor
* UIEvent
* UIView
* UILabel
* UITextField
* UITouch
* UIViewController

The output of these is (much?) more useful than the default.

CoreLocation
-----

> `require 'sugarcube-corelocation'`

Open up `CLLocationCoordinate2D` to provide handy-dandies

```ruby
# distances

> denver_co = CLLocationCoordinate2D.new(39.739188,-104.985223)
=> #<CLLocationCoordinate2D latitude=39.7391815185547 longitude=-104.985198974609>
> loveland_oh = CLLocationCoordinate2D.new(39.268128,-84.257648)
=> #<CLLocationCoordinate2D latitude=39.2681274414062 longitude=-84.2576293945312>
> denver_co.distance_to(loveland_oh)
=> 1773425.54893302  # in meters
> denver_co.distance_to(loveland_oh).in_miles
=> 1101.95556640625

# move around the globe using x/y distances in miles or kilometers
> denver_co.delta_miles(1101.6, -32.556)
=> #<CLLocationCoordinate2D latitude=39.2681427001953 longitude=-84.2577209472656>
# our location is pretty close!
> denver_co.delta_miles(1101.6, -32.556).distance_to(loveland_oh).miles
=> 0.90043306350708

> denver_co.delta_kilometers(10, 10)  # 10 kilometers east, 10 kilometers north
=> #<CLLocationCoordinate2D latitude=39.8290100097656 longitude=-104.868377685547>
```

Pipes
-----

This package short-circuits the `|` operator to perform coercion and filtering
between all sorts of objects.

### Coercion

Any object that defines a coercion method (image.uicolor, string.uiimage,
:symbol.uifont) can use the `|` and the class name to perform the same method.

```ruby
:label | UIFont  # => # :label.uifont
"image_name" | UIImage  # => "image_name".uiimage
view | UIImage | UIColor  # => view.uiimage.uicolor
```

### Filters

You can pipe objects that have some idea of "filter", like using an image mask
or image filter.

```ruby
image | mask  # => image.masked(mask)
image | darken_cifilter  # => image.apply_filter(darken_cifilter)
# this one is... interesting!
"My name is Mud" | /\w+$/   # => "Mud"
"My name is Mud" | /\d+$/   # => nil
"My name is Mud" | "Mud"  # => "Mud"
"My name is Mud" | "Bob"    # => nil
```

Awesome
-----

> `require 'sugarcube-awesome'`

SugarCube adds support for [Motion-Awesome][motion-awesome]!  The `awesome_icon`
method is added to `Symbol`, which returns an NSAttributedString that uses the
MotionAwesome font.  You can pass in `:size` and `:color` options.

`sugarcube-attributedstring` is not required for this extension to function, but
it adds `NSAttributedString` methods that really help.  Below I'm usind `#+` and
`#bold` and `#color` to construct an `NSAttributedString`.

```ruby
# in Rakefile
require 'sugarcube-awesome'
require 'sugarcube-attributedstring'

# in your app
label.attributedText = (:down_arrow.awesome_icon + ' Going down?'.bold).color(:white)
# OR for buttons
button.setAttributedTitle(:twitter.awesome_icon, forState:UIControlStateNormal)
```

[motion-awesome]: http://derailed.github.io/motion-awesome/

Anonymous
-----

> `require 'sugarcube-anonymous'`

Convert `Hash`es into an "anonymous object".  Existing keys will be able to be
accessed using method names.  Uses the `SugarCube::Anonymous` class to
accomplish this, though the usual interface is via `Hash#to_object`.

```ruby
h = { foo: 'FOO', 'bar' => 'BAR' }.to_object

# You can use methods instead of keys.
h.foo         # => h[:foo]
h.bar         # => h['bar']
h.foo = 'Foo' # => h[:foo] = 'Foo'
h.bar = 'Bar' # => h['bar'] = 'Bar'

# only existing keys are accessed this way
h.baz          # => NoMethodError
h.baz = 'baz'  # => NoMethodError
```

Unholy
-----

> `require 'sugarcube-unholy'`

I added these a long time ago to SugarCube, and so it's possible some people use
these extensions. Honestly, I should have put them somewhere else, they are
silly and not terribly useful, except maybe to me (I use them a lot!). :poop:

```ruby
class Baz ; end
foo = Baz.new

# (:symbol || 'string').ivar
foo.instance_variable_set(:bar.ivar, value)  # => foo.instance_variable_set(:@bar, value)
foo.instance_variable_set(var_name.ivar, value)  # => foo.instance_variable_set("@#{var_name}", value)

# (:symbol || 'string').setter
foo.send(varname.setter, 'value')

# (:symbol || 'string').cvar
Baz.class_variable_set(var_name.cvar, value)  # => Baz.class_variable_set("@@#{var_name}", value)
```

Legacy
-----

> `require 'sugarcube-legacy'`

This is where deprecated methods go to suffer a long, slow death.

Contributions
=====

If you want to see new features, please fork, commit, and pull-request! :smiley:

[BubbleWrap]: https://github.com/rubymotion/BubbleWrap
[sweettea]: https://github.com/colinta/sweettea
[teacup]: https://github.com/rubymotion/teacup
[nsnulldammit]: https://github.com/colinta/nsnulldammit
[geomotion]: https://github.com/clayallsopp/geomotion

[Fusionbox]: http://www.fusionbox.com/
[fusionbox announcement]: http://fusionbox.org/projects/rubymotion-sugarcube/
[Clay Allsopp]: https://github.com/clayallsopp
[Thom Parkin]: https://github.com/ParkinT
