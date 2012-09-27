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

**CONTRIBUTIONS**

SugarCube started out as a [Fusionbox][] project (see the
[announcement][fusionbox announcement]), but as its popularity increased, the
decision was made to offer it to the rubymotion community, in the spirit of
open-source and collaboration.  It is a great compliment to [teacup][],
especially when paired with [sweettea][]!


Installation
============

    gem install sugarcube

    # or in Gemfile
    gem 'sugarcube'

    # in Rakefile
    require 'sugarcube'

Examples
========

 Array
-------

```ruby
[1, 3].nsindexpath  # NSIndexPath.indexPathWithIndex(1).indexPathByAddingIndex(3)
[160, 210, 242].uicolor  # => UIColor.colorWithRed(0.6274, green:0.8235, blue:0.9490, alpha:1.0)
[160, 210, 242].uicolor(0.5)  # => UIColor.colorWithRed(0.6274, green:0.8235, blue:0.9490, alpha:0.5)
```

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

# convert to radians.  does this look weird?
180.degrees # => Math::PI

# convert multiples of pi
2.pi   # => 2 * Math::PI
0.5.pi # => 0.5 * Math::PI
```

 NSDate
--------

`NSDate` objects are converted to `Time` objects automatically by rubymotion.
That's the good news.  The bad news?  That still doesn't help a lot with some of
the everyday date&time crap we have to deal with. (I hate dates, especially
recurring events)

1. Adds the following methods to get date and time components: `date, time, datetime`.

   These methods return arrays.  Comparing dates, times, or both become
   simple `date1.date == date2.date`.
2. While I would love to support `date + 1.month` and have that support "smart"
   calendar math (e.g. "2/13/2013" + 1.month => "3/13/2013"), I can't fudge with
   the return value of `1.month` (=> `Fixnum`), and I won't make the terrible
   assumption that "30 days of seconds is *about* one month".  So instead, a new
   method that accepts date components as options is introduced.  `date.delta(month:1)`
3. Something that is often done is checking whether two dates are the same,
   ignoring the time components.  `start_of_day` and `end_of_day` methods help
   you here.  They are akin to `floor` and `ceil`, if you consider the time to
   be the "floating" component, and the date to be the nearest "integer".

```
(main)> now = NSDate.new  # Time.new is the same thing
=> 2012-09-13 09:19:06 -0600
(main)> now.date
=> [2012, 9, 13]
(main)> now.time
=> [9, 19, 6]
(main)> now.datetime
=> [2012, 9, 13, 9, 19, 6]
```

And it is easy to add seconds to the date using the time-related methods added
to `Numeric`, and the useful `start_of_day`/`end_of_day` methods.

```ruby
(main)> now + 5
=> 2012-09-13 09:19:11 -0600
(main)> now - 5
=> 2012-09-13 09:19:01 -0600
(main)> now + 5.minutes
=> 2012-09-13 09:24:06 -0600
(main)> now + 5.days
=> 2012-09-18 09:19:06 -0600
(main)> now.start_of_day
=> 2012-09-13 00:00:00 -0600
(main)> now.end_of_day
=> 2012-09-14 00:00:00 -0600
```

Time zone objects are available, but the `Time#utc_offset` method is a little
more useful.  It returns the offset *in seconds*, so divide by `1.0.hour` to get
the offset in hours.  `utc_offset` is built into `Time`, not added by SugarCube.

```ruby
(main)> now.timezone
=> #<__NSTimeZone:0x9384c70>
(main)> now.timezone.name
=> "America/Denver"
(main)> now.utc_offset
=> -21600
(main)> now.utc_offset / 1.hour
=> -6
```

The `delta` method is smart.

```ruby
(main)> feb_28_2012_stamp = 1330473600  # what, you don't have this memorized?
=> 1330473600
(main)> feb_28_2012 = Time.at(feb_28_2012_stamp)
=> 2012-02-28 17:00:00 -0700

(main)> feb_28_2012.delta(hours:1)
=> 2012-02-28 18:00:00 -0700
(main)> feb_28_2012.delta(hours:2)
=> 2012-02-28 19:00:00 -0700

(main)> feb_28_2012.delta(days:1)
=> 2012-02-29 17:00:00 -0700
(main)> feb_28_2012.delta(days:2)
=> 2012-03-01 17:00:00 -0700

(main)> feb_28_2012.delta(months:1)
=> 2012-03-28 17:00:00 -0600  # look, the time didn't change, event though there was a DST change!
(main)> feb_28_2012.delta(months:1, hours:0)
=> 2012-03-28 18:00:00 -0600  # disable the DST fix by specifying hours, minutes, or seconds (a "precise" delta)

(main)> feb_28_2012.delta(years:1)
=> 2013-02-28 17:00:00 -0700
(main)> feb_28_2012.delta(days:1, years:1)
=> 2013-02-28 17:00:00 -0700
(main)> feb_28_2012.delta(days:1, years:1, months:1)
=> 2013-03-29 17:00:00 -0600

(main)> jan_29_2013 = feb_28_2012.delta(days:1, months:11)
=> 2013-01-29 17:00:00 -0700

# what is 1/29/2013 plus two months?  easy!  march 29, 2013
(main)> jan_29_2013.delta(months:2)
=> 2013-03-29 17:00:00 -0600

# yeah, smart guy? well then what is 1/29/2013 plus ONE month.
# it's feb 28th.  trust me.  when someone says "see you in a month!"
# they mean "next month", not "in the early part of two months in the future",
# which is where the math will take you if you don't add a "day of month" correction.
(main)> jan_29_2013.delta(months:1)
=> 2013-02-28 17:00:00 -0700

# does it work in reverse?  fuuuuuu...
(main)> jan_29_2013.delta(months:-11)
=> 2012-02-29 17:00:00 -0700
# ...ck yeah!  :-)

# unfortunately you will end up with stuff like this:
(main)> feb_28_2012 == feb_28_2012.delta(days:1, months:12).delta(months:-12)
=> true
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
"my_image".uiimage  # => UIImage.imageNamed("my_image")
"blue".uicolor  # => UIColor.colorWithPatternImage(UIImage.imageNamed("blue"))

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

 NSIndexPath
-------------

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

 Symbol
--------

This is the "big daddy".  Lots of sugar here...

```ruby
:center.uialignment  # => UITextAlignmentCenter
:upside_down.uiorientation  # => UIDeviceOrientationPortraitUpsideDown
:rounded.uibuttontype  # => UIButtonTypeRoundedRect
:highlighted.uicontrolstate  # => UIControlStateHighlighted
:touch.uicontrolevent  # => UIControlEventTouchUpInside
:changed.uicontrolevent  # => UIControlEventValueChanged
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
:bar.uisegmentedstyle   # :plain, :bordered, :bar, :bezeled

# UITableView and UITableViewCell have LOTS of associated constants... I'm
# adding them as I come across them.
:automatic.uitablerowanimation   # or .uitableviewrowanimation
:default.uitablecellstyle        # or .uitableviewcellstyle
:disclosure.uitablecellaccessory  # or .uitableviewcellaccessorytype
:blue.uitablecellselectionstyle  # or .uitableviewcellselectionstyle
```

 UIImage
---------

```ruby
image = "my_image".uiimage
image.uicolor # => UIColor.colorWithPatternImage(image)
```

 UIAlertView
--------

Accepts multiple buttons and success and cancel handlers.  In its simplest
form, you can pass just a title and block.

```ruby
# simple
UIAlertView.alert "This is happening, OK?" { self.happened! }
# a little more complex
UIAlertView.alert("This is happening, OK?", buttons: ["Nevermind", "OK"],
  message: "don't worry, it'll be fine.") {
  self.happened!
}

# Full on whiz bangery.  Note the success block takes the pressed button, but as
# a string instead of an index.  The cancel button should be the first entry in
# `buttons:`
UIAlertView.alert "I mean, is this cool?", buttons: %w[No! Sure! Hmmmm],
  message: "No going back now",
  cancel: proc { self.cancel },
  success: proc { |pressed| self.proceed if pressed == "Sure!" }
```

 UIView
--------

```ruby
UIView.first_responder  # => returns the first responder, starting at UIApplication.sharedApplication.keyWindow
my_view.first_responder  # => also returns the first responder, but starts looking in my_view
self.view << subview  # => self.view.addSubview(subview)
self.view.show  # => self.hidden = false
self.view.hide  # => self.hidden = true
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

##### View factories

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
```

###### UITableView

```ruby
UITableView.alloc.initWithFrame([[0, 0], [320, 480]], style: :plain.uitableviewstyle)
# custom frame:
UITableView.alloc.initWithFrame([[0, 0], [320, 400]], style: :grouped.uitableviewstyle)

# =>

UITableView.plain
# custom frame:
UITableView.grouped([[0, 0], [320, 400]])
```

###### UISegmentedControle

```ruby
control = UISegmentedControl.alloc.initItems(["one", "ah-two-whoo", "thr-r-r-ree"])
control.segmentedControlStyle = :bar.uisegmentedstyle

# =>

UISegmentedControl.bar(["one", "ah-two-whoo", "thr-r-r-ree"])
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

 UIViewController
------------------

It is nice that *any* `UIViewController` can present a modal, but if you have
tabs or navs or crap in the way, this is actually *NOT* what you want.  You
should use the `rootViewController` (whatever it may be) to present to modal.

And since this is a property on `UIWindow`, which is more-or-less a constant, we
can make this the easiest to do!

```ruby
include SugarCube::Modal
view_ctlr = EditSomethingViewController.new
present_modal(view_ctlr)
# ...later, when all is well...
dismiss_modal
```

These accept completion blocks:

```ruby
present_modal(view_ctlr) { puts "here!" }
dismiss_modal { puts "gone!" }
```

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

 UITabBarController
------------------------

I have mixed feelings about adding this extension, but **I** needed it, so maybe
you will, too...  Usually `UITabBarController`s have a static number of tabs,
but in my case, I needed to be able to add one later, when a certain condition
was met.

```ruby
controllers = tabbar_ctlr.viewControllers
controllers << new_ctlr
tabbar_ctlr.setViewControllers(controllers, animated: true)

# =>

tabbar_ctlr << new_ctlr
```

 NSNotificationCenter
----------------------

Makes it easy to post a notification to some or all objects.

```ruby
# this one is handy, I think:
"my notification".post_notification  # => NSNotificationCenter.defaultCenter.postNotificationName("my notification", object:nil)
"my notification".post_notification(obj)  # => NSNotificationCenter.defaultCenter.postNotificationName("my notification", object:obj)
"my notification".post_notification(obj, user: 'dict')  # => NSNotificationCenter.defaultCenter.postNotificationName("my notification", object:obj, userInfo:{user: 'dict'})

# very similar to add or remove an observer
"my notification".add_observer(observer, :method_name)
"my notification".add_observer(observer, :method_name, object)

# remove the observer
"my notification".remove_observer(observer)
"my notification".remove_observer(observer, object)
```

 NSTimer
---------

```ruby
1.second.later do
  @view.shake
end

1.second.every do
  @view.shake
end

# since that looks funny, an every method is available in the SugarCube::Timer module
include SugarCube::Timer
every 1.minute do
  puts "tick"
end

# might as well make an alias
after 1.minute do
  puts "ding!"
end

# other time-related methods
# for compatibility with Time methods, the mins/secs (and min/sec) aliases are provided.  Personally,
# I like the more verbose minutes/seconds.
1.second  || 2.seconds
1.sec     || 2.secs     # aliases
1.minute  || 2.minutes  # 1.minute = 60 seconds
1.min     || 2.mins     # aliases
1.hour    || 2.hours    # 1.hour = 60 minutes
1.day     || 2.days     # 1.day = 24 hours
1.week    || 2.weeks    # 1.week = 7 days
# sensible values for 'month' and 'year', even though we all know you can't
# **really** define them this way (go back to python if you find your brain
# hemorrhaging):
1.month   || 2.months   # 1.month = 30 days
1.year    || 2.years    # 1.year = 365 days
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

Instead, just use `Rect`, `Size` and `Point`.  They will happily convert most
sensible arguments into a `Rect/Size/Point`, which can be treated as a `CGRect`
object OR as an `Array` (woah).

These are namespaced in `SugarCube::CoreGraphics` module, but I recommend you
`include SugarCube::CoreGraphics` in app_delegate.rb.

```ruby
f = Rect(view.frame)  # converts a CGRect into a Rect
o = Point(view.frame.origin)  # converts a CGPoint into a Point
s = Size(view.frame.size)  # converts a CGSize into a Size

# lots of other conversions are possible.
# a UIView or CALayer => view.frame
f = Rect(view)
# 4 numbers
f = Rect(x, y, w, h)
# or two arrays
p = Point(x, y)  # or just [x, y] works, too
s = Size(w, h)  # again, [w, h] is fine
f = Rect(p, s)
# like I said, a straight-up array of nested arrays is fine, too.
f = Rect([[x, y], [w, h]])
```

###### CG{Rect,Point,Size} is a *real boy*!

These methods get defined in a module (`SugarCube::CG{Rect,Size,Point}Extensions`),
and included in `CGRect` *and* `Rect`.  The idea is that you do not have to
distinguish between the two objects.

These methods all use the methods as described in [CGGeometry Reference][], e.g.
`CGRectContainsPoint`, `CGRectIntersectsRect`, etc.

```ruby
# intersection / contains
Point(0, 0).intersects?(Rect(-1, -1, 2, 2))  # => true
# if a Point intersects a Rect, the Rect intersects the Point, right?
Rect(-1, -1, 2, 2).intersects? Point(0, 0)  # => true

# CGRect and the gang are real Ruby objects.  Let's treat 'em that way!
view.frame.contains? Point(10, 10)  # in this case, contains? and intersects? are synonyms
view.frame.intersects? Rect(0, 0, 10, 10)  #  <= but this one
view.frame.contains? Rect(0, 0, 10, 10)    #  <= and this one are different.

# CGRect has factory methods for CGRectEmpty, CGRectNull, and - KINDA - CGRectInfinite
# BUT, there is a bug (?) right now where CGRectIsInfinite(CGRectInfinite) returns false.
# so instead, I've built my own infinite? method that checks for the special "Infinite" value
> CGRect.infinite
=> [[0, 0], [Infinity, Infinity]]
> CGRect.infinite.infinite?
=> true
> CGRect.null
=> [[Infinity, Infinity], [0.0, 0.0]]
> CGRect.null.null?
=> true
> CGRect.empty
=> [[0.0, 0.0], [0.0, 0.0]]
> CGRect.empty.empty?
=> true
```

A lot of the methods in CGGeometry Reference are available as instance methods

```ruby
view.frame.left    # => CGRectGetMinX(view.frame)
view.frame.right   # => CGRectGetMaxX(view.frame)
view.frame.top     # => CGRectGetMinY(view.frame)
view.frame.bottom  # => CGRectGetMaxY(view.frame)
view.frame.width   # => CGRectGetWidth(view.frame)
view.frame.height  # => CGRectGetHeight(view.frame)
view.frame.center  # => Point(CGRectGetMidX(view.frame), CGRectGetMidY(view.frame))

view.frame.intersection(another_rect)  # => CGRectIntersection(view.frame, another_rect)
view.frame + another_rect  # => CGRectUnion(view.frame, another_rect)
view.frame + a_point  # => CGRectOffset(view.frame, a_point.x, a_point.y)
view.frame + a_offset  # => CGRectOffset(view.frame, a_offset.horizontal, a_offset.vertical)
view.frame + edgeinsets  # => UIEdgeInsetsInsetRect(view.frame, edgeinsets)
view.frame + a_size  # => CGRectInset(view.frame, -a_size.width, -a_size.height)
# Adding a size to a view keeps the view's CENTER in the same place, but
# increases its size by `size.width,size.height`. it's the same as using
# UIEdgeInsets with top == bottom, and left == right
> Rect(0, 0, 10, 10).center
=> Point(5.0, 5.0)  # note the center
> Rect(0, 0, 10, 10) + Size(10, 10)
=> Rect([-10.0, -10.0],{30.0 × 30.0})  # origin and size changed, but...
> (Rect(0, 0, 10, 10) + Size(10, 10)).center
=> Point(5.0, 5.0)
# See?  It's bigger, but the center hasn't moved.
```

`to_hash/from_hash`, and notice here that I used `inspect`, to show that it is a
little more readable.

**NOTE** As of today, Aug. 25, 2012, rubymotion v1.22, the `inspect` method in SugarCube is not
being called.  I think this is a bug... this worked before!

```ruby
> Rect(0, 0, 10, 10).to_hash
=> {"Width"=>10.0, "Height"=>10.0, "Y"=>0.0, "X"=>0.0}
> puts CGRect.from_hash(Rect(0, 0, 1, 1).to_hash).inspect
CGRect([0.0, 0.0],{1.0 × 1.0})
```

`to_s/from_s`, which rely on `NSStringFromCGRect/CGRectFromString` (et. al.)

```ruby
> Rect(0, 0, 10, 10).to_s
=> "{{0, 0}, {10, 10}}"
> puts CGRect.from_s Rect(0, 0, 10, 10).to_s
{{0, 0}, {10, 10}}
```

[CGGeometry Reference]: https://developer.apple.com/library/mac/documentation/graphicsimaging/reference/CGGeometry/Reference/reference.html

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

 Pointers
----------

These are not UIKit-related, so I reverted to Ruby's preferred `to_foo`
convention.

```ruby
[0.0, 1.1, 2.2].to_pointer(:float)

floats = Pointer.new(:float, 3)
floats[0] = 0.0
floats[1] = 1.1
floats[2] = 2.2
```

 UUID
------

Quick wrapper for `CFUUIDCreate()` and `CFUUIDCreateString()`.  Identical to the
`BubbleWrap::create_uuid` method.

```ruby
> SugarCube::UUID::uuid
"0A3A76C6-9738-4458-969E-3B9DF174A3D9"

# or
> include SugarCube::UUID
> uuid
# => "0A3A76C6-9738-4458-969E-3B9DF174A3D9"
```

[BubbleWrap]: https://github.com/rubymotion/BubbleWrap
[sweettea]: https://github.com/colinta/sweettea
[teacup]: https://github.com/rubymotion/teacup
[Fusionbox]: http://www.fusionbox.com/
[fusionbox announcement]: http://fusionbox.org/projects/rubymotion-sugarcube/
