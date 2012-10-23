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

1. Adds the following methods to get date and time components: `date_array, time_array, datetime_array`.

   These methods return arrays.  Comparing dates, times, or both become
   simple `date1.date_array == date2.date_array`.
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
(main)> now.date_array
=> [2012, 9, 13]
(main)> now.time_array
=> [9, 19, 6]
(main)> now.datetime_array
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
(main)> feb_28_2012 = Time.at(1330473600)
=> 2012-02-28 17:00:00 -0700

# add an hour or two
(main)> feb_28_2012.delta(hours:1)
=> 2012-02-28 18:00:00 -0700
(main)> feb_28_2012.delta(hours:2)
=> 2012-02-28 19:00:00 -0700

# add some days
(main)> feb_28_2012.delta(days:1)
=> 2012-02-29 17:00:00 -0700
(main)> feb_28_2012.delta(days:2)
=> 2012-03-01 17:00:00 -0700

# how about a month?
(main)> feb_28_2012.delta(months:1)
=> 2012-03-28 17:00:00 -0600  # look, the time didn't change, event though there was a DST change!

# cool, but if you want a more literal "24 hours", specify a time unit
(main)> feb_28_2012.delta(months:1, hours:0)
=> 2012-03-28 18:00:00 -0600  # disable the DST fix by specifying hours, minutes, or seconds (a "precise" delta)

# in one year, it will still be Feb 28th
(main)> feb_28_2012.delta(years:1)
=> 2013-02-28 17:00:00 -0700

# and we already know what adding a day looks like
(main)> feb_28_2012.delta(days:1)
=> 2012-02-29 17:00:00 -0700

# a year and a day is tricky, because do we add a day, then a year?  or add a
# year and then a day?  well, i'll tell you, **I** add a day and then a year,
# which is feb 29th, which is no good, and the algorithm rolls back days to the
# last day of the month, so we get the 28th.
(main)> feb_28_2012.delta(days:1, years:1)
=> 2013-02-28 17:00:00 -0700

# adding 2 days puts us into March, which then "looks right", but it's both
# right AND wrong, depending on how you look at it.  Another example is below,
# where we add a month to January 30th.  Really, though, think of this: how
# often do you need to add a year AND a day!?  Adding a year is more common, and
# this is showing that adding a year to Feb 29th will give you Feb 28th, which I
# think is better than March 1st.
(main)> feb_28_2012.delta(days:2, years:1)
=> 2013-03-01 17:00:00 -0700

# Crazier: add a day (fab 29th), then a month (march 29th), THEN a year.
(main)> feb_28_2012.delta(days:1, years:1, months:1)
=> 2013-03-29 17:00:00 -0600

# k, for the next examples, we need a new date, and this is a non-leap year.
(main)> jan_29_2013 = feb_28_2012.delta(days:1, months:11)
=> 2013-01-29 17:00:00 -0700

# what is 1/29/2013 plus two months?  easy!  march 29, 2013
(main)> jan_29_2013.delta(months:2)
=> 2013-03-29 17:00:00 -0600

# Yeah, smart guy?  Well then what is 1/29/2013 plus ONE month. It's feb 28th.
# When someone says "see you in a month!" they mean "next month", not "in the
# early part of two months in the future", which is where the math will take you
# if you don't add a "day of month" correction.
(main)> jan_29_2013.delta(months:1)
=> 2013-02-28 17:00:00 -0700
# but last year was a leap year, so we should get Feb 29th, 2012:
(main)> jan_29_2013.delta(months:1, years: -1)
=> 2012-02-29 17:00:00 -0700  # success!

# do other deltas work in reverse?  fuuuuuu...
(main)> jan_29_2013.delta(months:-11)
=> 2012-02-29 17:00:00 -0700
# ...ck yeah!  :-)

# unfortunately you will, in the edge cases, end up with stuff like this:
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
:change.uicontrolevent  # => UIControlEventValueChanged
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

###### UIActivityViewIndicator

```ruby
UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(:white.uiactivityindicatorstyle)
UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(:large.uiactivityindicatorstyle)
UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(:gray.uiactivityindicatorstyle)

# =>

UIActivityIndicatorView.white
UIActivityIndicatorView.large
UIActivityIndicatorView.gray
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

 UITextView
------------

Added some `UIControl`-like event binding.  You MUST call the `off` methods,
because these methods use `NSNotification`s, and you must turn off listeners.

There are two aliases for each event. I prefer the present tense (jQuery-style `on :change`),
but UIKit prefers past simple (`UITextViewTextDidBeginEditingNotification`).

So these are all the same:

    :editing_did_begin  :begin
    :editing_did_change :change
    :editing_did_end    :end

```ruby
text_view = UITextView.new
text_view.on :editing_did_begin do
  p 'wait for it...'
end
text_view.on :editing_did_change do
  p text_view.text
end
text_view.on :editing_did_end do
  p 'done!'
end

# later... like in `viewWillDisappear`.  I'll use the alternative aliases here
text_view.off :change, :end, :begin
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
> down  # defaults to 1 anyway
> left 1
> right 1  # same as up -1, obviously
> left  # => left 1
> origin 10, 12  # move to x:10, y:12
> wider 1
> thinner 1
> taller  # => taller 1
> shorter  # => shorter 1
> size 100, 10  # set size to width:100, height: 10
> shadow(opacity: 0.5, offset: [0, 0], color: :black, radius: 1) # and path, which is a CGPath object.
> center  # See `Centering` section below
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
=> UITextField(#9ce6470, {{46, 214}, {280, 33}},  child of UIView(#10a6da20)
```

The most useful feature of the REPL adjustment is the ability to quickly
position and size your UI elements __visually__ and then paste the final values
into your code.  In order to better accomodate that, `adjust` has an option to
modify the output format.

This better facilitates copy/paste of the values.  Currently supported is:
* Default (RubyMotion) (`nil`, `:default`)
* Objective-C (`:objc`)
* JSON (`:json`)

#### Objective-C style

```
(UIImageView(#8d67e00, {{0, 0},...)> tree
  0: . UIWindow(#6e27180: {{0, 0}, {320, 480}})
  1: `-- UIView(#8d631b0: {{0, 20}, {320, 460}})
  2:     +-- UIButton(#6d6c090: {{10, 10}, {320, 463.401}})
  3:     |   `-- UIImageView(#8d67e00: {{0, 0}, {320, 463.401}})
  4:     `-- UIRoundedRectButton(#8d68170: {{10, 30}, {30, 200}})
  5:         `-- UIButtonLabel(#8d69c30: {{2, 90}, {26, 19}})
=> UIWindow(#6e27180, {{0, 0}, {320, 480}},

# you can pass the format into the adjust method:
(UIImageView(#8d67e00, {{0, 0},...)> a 4, :objc
=> "UIRoundedRectButton(#8d68170: [[10.0, 30.0], [200.0, 30.0]])"

# or you can assign repl_format explicitly (adjust does this for you when you hand it a format)
(UIImageView(#8d67e00, {{0, 0},...)> repl_format :objc
=> :objc

# either way, it will continue to be used in subsequent calls
(UIImageView(#8d67e00, {{0, 0},...)> wider 15
[[10.0, 30.0], [200.0, 45.0]]
=> "UIRoundedRectButton(#8d68170: [[10.0, 30.0], [200.0, 45.0]]) child of UIView(#8d631b0)"
```

#### JSON (or GeoMotion)

```
(UIImageView(#8d67e00, {{0, 0},...)> a 1, :json
=> "UIView(#8d631b0: [x: 0.0, y: 20.0, height: 460.0, width: 320.0])"
(UIImageView(#8d67e00, {{0, 0},...)> wider 30
=> "CGRect(#6e9c9f0: [x: 0.0, y: 20.0, height: 460.0, width: 350.0])"
(UIImageView(#8d67e00, {{0, 0},...)> right 130
=> "CGRect(#8dc6a40: [x: 130.0, y: 20.0, height: 460.0, width: 350.0])"
(UIImageView(#8d67e00, {{0, 0},...)> tree
  0: . UIWindow(#6e27180: [x: 0.0, y: 0.0, height: 480.0, width: 320.0])
  1: `-- UIView(#8d631b0: [x: 130.0, y: 20.0, height: 460.0, width: 350.0])
  2:     +-- UIButton(#6d6c090: [x: 10.0, y: 10.0, height: 463.400512695312, width: 320.0])
  3:     |   `-- UIImageView(#8d67e00: [x: 0.0, y: 0.0, height: 463.400512695312, width: 320.0])
  4:     `-- UIRoundedRectButton(#8d68170: [x: 10.0, y: 30.0, height: 200.0, width: 45.0])
  5:         `-- UIButtonLabel(#8d69c30: [x: 4.0, y: 90.0, height: 19.0, width: 37.0])
=> UIWindow(#6e27180, {{0, 0}, {320, 480}},
```

Note: The `format` parameter can be passed as either a symbol or a string

###  CENTER (in parent frame)
It is called as `center(which_element, of_total_number, horizontal_or_vertical, verbose_output)`
#### you can set 'direction' with any number of forms: 'horiz', 'vert', 'x', 'x and y'

Here are a few examples:

The default is to center the current element _horizontally_

```
(main)> center
[[145.0, 30.0], [30.0, 200.0]]
UIRoundedRectButton.origin = [145.0, 30.0]
=> "[[145.0, 30.0], [30.0, 200.0]]"
```

In order to place that same button in the CENTER of the screen, you can use this shorthand syntax:
`center 1,1,"xy"` or `center 1,1,:xy`

For the `horizontal_or_vertical` parameter, strings and symbols are interchangable

If you have three buttons and want them spaced evenly (vertically) across their parent frame, you can call it this way:
```
(main)> tree
  0: . UIWindow(#6e1f950: [[0.0, 0.0], [320.0, 480.0]])
  1: `-- UIView(#8b203b0: [[0.0, 20.0], [320.0, 460.0]])
  2:     +-- UIButton(#d028de0: [[10.0, 10.0], [320.0, 463.400512695312]])
  3:     |   `-- UIImageView(#d02aaa0: [[0.0, 0.0], [320.0, 463.400512695312]])
  4:     +-- UIRoundedRectButton(#d02adb0: [[55.0, 110.0], [210.0, 20.0]])
  5:     |   `-- UIButtonLabel(#d02af00: [[73.0, 0.0], [63.0, 19.0]])
  6:     +-- UIRoundedRectButton(#d028550: [[60.0, 30.0], [200.0, 20.0]])
  7:     |   `-- UIButtonLabel(#d02afb0: [[68.0, 0.0], [63.0, 19.0]])
  8:     `-- UIRoundedRectButton(#d02b220: [[70.0, 30.0], [300.0, 20.0]])
  9:         `-- UIButtonLabel(#d02b300: [[118.0, 0.0], [63.0, 19.0]])
=> UIWindow(#6e1f950, [[0.0, 0.0], [320.0, 480.0]])
(main)> a 4; center 1, 3, :vert, false; center
[[55.0, 110.0], [210.0, 20.0]]
[[55.0, 110.0], [210.0, 20.0]]
UIRoundedRectButton.origin = [55.0, 110.0]
=> "[[55.0, 110.0], [210.0, 20.0]]"
(main)> a 6; center 2, 3, :vert, false; center
[[60.0, 220.0], [200.0, 20.0]]
[[60.0, 220.0], [200.0, 20.0]]
UIRoundedRectButton.origin = [60.0, 220.0]
=> "[[60.0, 220.0], [200.0, 20.0]]"
(main)> a 8; center 3, 3, :vert, false; center
[[70.0, 330.0], [300.0, 20.0]]
[[10.0, 330.0], [300.0, 20.0]]
UIRoundedRectButton.origin = [10.0, 330.0]
=> "[[10.0, 330.0], [300.0, 20.0]]"
```
The calculated positions (x,y) are in the REPL output


**Don't stop there!**

You can analyze `UIViewController` hierarchies, too.  There's even a handy
`root` method to grab the `rootViewController`:

```ruby
(main)> tree root
  0: . #<MainScreenController:0xac23b80>
  1: +-- #<ScheduleViewController:0x13185d00>
  2: |   +-- #<ScheduleTableController:0x131862f0>
  3: |   `-- #<ScheduleCalendarController:0x131bba90>
  4: +-- #<CameraViewController:0x13191380>
  5: +-- #<UINavigationController:0xac01ea0>
  6: |   `-- #<UITableController:0xac04e30>
  7: +-- #<PicturesViewController:0x1403ede0>
  8: `-- #<MessagesViewController:0x131a1bc0>
=> #<MainScreenController:0xac23b80>
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

 Ruby on Rails Ripoffs (RoR-R?)
---------------

```ruby
# truthiness with `blank?`
nil.blank?    # => true
false.blank?  # => true
''.blank?     # => true
[].blank?     # => true
{}.blank?     # => true

0.blank?        # => false
true.blank?     # => false
'a'.blank?      # => false
['a'].blank?    # => false
{a: 'a'}.blank? # => false
```
