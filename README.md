SugarCube
=========

Some sugar for your cocoa, or your [tea][sweettea].

[![Build Status](https://travis-ci.org/rubymotion/sugarcube.png)](https://travis-ci.org/rubymotion/sugarcube)

About
-----

CocoaTouch/iOS is a *verbose* framework.  These extensions hope to make
development in rubymotion more enjoyable by tacking "UI" methods onto the base
classes (String, Fixnum, Numeric).  With SugarCube, you can create a color from an
integer or symbol, or create a UIFont or UIImage from a string.

Some UI classes are opened up as well, like adding the '<<' operator to a UIView
instance, instead of view.addSubview(subview), you can use the more idiomatic:
view << subview.

The basic idea of SugarCube is to turn some operations on their head.  Insead of

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
open-source and collaboration.  It is a great compliment to [teacup][],
especially when paired with [sweettea][]!

Documentation
=============

A work in progress.  This README is the best source, but I am trying to be more
diligent about adding Yard documentation, which is available here:

<http://rubydoc.info/gems/sugarcube/latest>


Installation
============

    gem install sugarcube

    # in Rakefile
    require 'sugarcube'

    # or in Gemfile
    gem 'sugarcube'

    # in terminal
    $ bundle install

Examples
========

 Array
-------

```ruby
[1, 3].nsindexpath  # NSIndexPath.indexPathWithIndex(1).indexPathByAddingIndex(3)
[160, 210, 242].uicolor  # => UIColor.colorWithRed(0.6274, green:0.8235, blue:0.9490, alpha:1.0)
[160, 210, 242].uicolor(0.5)  # => UIColor.colorWithRed(0.6274, green:0.8235, blue:0.9490, alpha:0.5)
```

 Hash => Object
--------

```ruby
require 'sugarcube-attributedstring'
```

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

 Fixnum
--------

```ruby
# create a UIColor from a hex value
0xffffff.uicolor # => UIColor.colorWithRed(1.0, green:1.0, blue:1.0, alpha:1.0)
0xffffff.uicolor(0.5) # => UIColor.colorWithRed(1.0, green:1.0, blue:1.0, alpha:0.5)

# some number-to-string stuff
1.nth  # => 'st'
2.nth  # => 'nd'
3.nth  # => 'rd'
4.nth  # => 'th'
11.nth  # => 'th'
13.nth  # => 'th'
21.nth  # => 'st'
23.nth  # => 'rd'

NSDate.new  # => 2013-01-03 11:42:24 -0700
5.days.ago  # => 2012-12-29 11:42:24 -0700
5.days.before(NSDate.new)  # => 2012-12-29 11:42:24 -0700
5.days.hence  # => 2013-01-08 11:42:24 -0700
5.days.after(NSDate.new)  # => 2013-01-08 11:42:24 -0700
# don't confuse 'after' and 'later'
# after => NSDate
# later => NSTimer
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

# if you thought conversion from degrees to radians looks weird, you'll hate
# conversion from meters to miles:
distance = 1500  # this is in meters.  why?  because all the methods that return
  # a "distance" return it in meters
distance.miles  # => 0.932056427001953

# use NSNumberFormatter to easily format a number in the current locale
10000.string_with_style  # => "10,000"
10000.string_with_style(NSNumberFormatterCurrencyStyle)  # => "$10,000.00"
10000.string_with_style(:currency)  # => "$10,000.00"
```

 NSAttributedString
---------

```ruby
require 'sugarcube-attributedstring'
```

These become pretty fun!  Check out `nsattributedstring_spec.rb` for all the
supported attributes (in theory they are all supported, but there's weird
issues with missing constants).

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

And you can easily turn this into a label!

```ruby
view << (("We just met\n".attrd +
          "and this is " + "CRAZY".italic + "\n"
          "But here's my " + "id_rsa.pub".monospace + " file,\n" +
          "so give me SSH access.").uilabel
```

 NSCoder
---------

Shorthands and hash-like access to the coder/decoder objects.

```ruby
# hash access is the handiest
coder['key'] = self.value
self.value = decoder['key']

# but if you want to store booleans and such (in their C form,
# which will take up less space I suppose):
coder.set('sugarcube_is_neat', toBool:self.sugarcube_is_neat?)
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
------

Going to and from `NSData` is really useful when doing HTTP posts.

```ruby
string_data = 'String'.nsdata  # => default encoding is UTF8.
image = 'an image'.uiimage
image_data = image.nsdata  # PNG data representation

string_data.nsstring  # => 'String'
image_data.nsimage  # => whatever 'an image' was
```

 NSDate
--------

`NSDate` objects are converted to `Time` objects automatically by rubymotion.
That's the good news.
The bad news?  That still doesn't help a lot with some of
the everyday date & time crap we have to deal with. (I hate dates, especially
recurring events)
##### NSDate

1. Adds the following methods to get date and time components: `date_array, time_array, datetime_array`.
   These methods return arrays.  Comparing dates, times, or both become
   simple `date1.date_array == date2.date_array`.
2. While I would love to support `date + 1.month` and have that support "smart"
   calendar math (e.g. "2/13/2013" + 1.month => "3/13/2013"), I can't fudge with
   the return value of `1.month` (=> `Fixnum`), and I won't make the terrible
   assumption that "30 days of seconds is *about* one month".  So instead, a new
   method that accepts date components as options is introduced:  `date.delta(months:1)`
3. Checking whether two dates are the same, ignoring the time components, is often required
`start_of_day` and `end_of_day` methods help
   you here.  They are akin to `floor` and `ceil`; if you consider the time to
   be the "floating" component, and the date to be the nearest "integer".
4. Formatting is made easier with `NSDate#string_with_style(NSDateStyleConstant or Symbol for date, time)`
   and `NSDate#string_with_format(format_string)`.  See
   <http://www.unicode.org/reports/tr35/tr35-25.html#Date_Format_Patterns> for
   the formatters, they take getting used to, coming from `strftime`, but they
   are much more powerful and locale-aware.
5. Miscellaneous other helpers.  I'll go over these first.

###### Helpers

```ruby
(main)> now = NSDate.new  # Time.new is the same thing
=> 2012-09-13 09:19:06 -0600

# NSDate##from_components
(main)> feb_1_2013 = NSDate.from_components(year: 2013, month: 2, day:1)
=> 2013-02-01 00:00:00 -0700
(main)> feb_1_2013_sometime_later = NSDate.from_components(year: 2013, month: 2, day:1, hour:13, minute: 59, second:30)
=> 2013-02-01 13:59:30 -0700
(main)> feb_1_2012 = NSDate.from_components(year: 2012, month: 2, day:1)
=> 2012-02-01 00:00:00 -0700


(main)> feb_1_2013.timezone.name
=> "America/Denver"
(main)> feb_1_2013.era
=> 1  # no, I don't know what this is :-/
(main)> feb_1_2013.today?
=> false  # actually, at the time I am WRITING this, it IS true, but by the time
          # you read it, not so much ;-)
(main)> NSDate.new.today?
=> true
(main)> feb_1_2013.same_day?(NSDate.new)
=> false
(main)> feb_1_2013.same_day?(feb_1_2013_sometime_later)
# even though the time is different!?
=> true
(main)> feb_1_2013.utc_offset
=> -25200
(main)> feb_1_2013.leap_year?
=> false
(main)> NSDate.from_components(year: 2012).leap_year?
=> true
(main)> feb_1_2013.start_of_day
=> 2013-02-01 00:00:00 -0700
(main)> feb_1_2013.end_of_day
# NOTE! end_of_day is the NEXT DAY.  this is not an accident, it makes comparisons cleaner.  deal with it.
=> 2013-02-02 00:00:00 -0700
(main)> feb_1_2013.start_of_week  # in the USA, start of week is Sunday
=> 2013-01-27 00:00:00 -0700
=> 2013-01-28 00:00:00 -0700  # in most other countries you will get Monday
(main)> feb_1_2013.start_of_week(:monday)  # or you can specify it!
=> 2013-01-28 00:00:00 -0700
(main)> feb_1_2013.end_of_week  # Just like end_of_day, end_of_week returns midnight of the *next day*
=> 2013-02-03 00:00:00 -0700
(main)> feb_1_2013.end_of_week(:monday)
=> 2013-02-04 00:00:00 -0700
(main)> feb_1_2013.days_in_month
=> 28
(main)> feb_1_2013.days_in_year
=> 365
(main)> feb_1_2012.days_in_month
=> 29
(main)> feb_1_2012.days_in_year
=> 366

(main)> now.date_array
=> [2012, 9, 13]
(main)> now.time_array
=> [9, 19, 6]
(main)> now.datetime_array
=> [2012, 9, 13, 9, 19, 6]
```

Use `NSDate#string_with_style` to generate date and/or time strings.

```ruby
(main)> now.string_with_style
=> "January 29, 2013"
(main)> now.string_with_style(NSDateFormatterShortStyle)
=> "1/29/13"
(main)> now.string_with_style(:short)
=> "1/29/13"
(main)> now.string_with_style(NSDateFormatterMediumStyle, NSDateFormatterShortStyle)
=> "Jan 29, 2013, 9:19 AM"
(main)> now.string_with_style(:short, :medium)
=> "1/29/13, 9:19:06 AM"
(main)> now.string_with_style(:none, :long)
=> "9:19:06 AM GMT+01:00"
```

It is easy to add seconds to the date using the time-related methods added to
`Numeric`, though the `NSDate#delta` method is MUCH more capable.

```ruby
(main)> now + 5
=> 2012-09-13 09:19:11 -0600
(main)> now - 5
=> 2012-09-13 09:19:01 -0600
(main)> now + 5.minutes
=> 2012-09-13 09:24:06 -0600
(main)> now + 5.days
=> 2012-09-18 09:19:06 -0600
```

Time zone objects are available, but the `Time#utc_offset` method is a little
more useful.  It returns the offset *in seconds*, so divide by `1.0.hour` to get
the offset in hours.  `utc_offset` is built into `Time`, not added by SugarCube,
but it is added to the `NSDate` class in case you get one of those instead.

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

The `delta` method is smart.  See the tests!  It will do its best to compensate
for daylight savings, leap years, different numbers of days in the month, and so
on.

```ruby
(main)> feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28)
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
=> 2012-03-28 17:00:00 -0600  # look, the time didn't change, event though there was a DST change in this period!

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

# Crazier: add a day (Feb 29th), then a month (March 29th), THEN a year.
(main)> feb_28_2012.delta(days:1, years:1, months:1)
=> 2013-03-29 17:00:00 -0600

# k, for the next examples, we need a new date, and this is a non-leap year.
(main)> jan_29_2013 = feb_28_2012.delta(days:1, months:11)
=> 2013-01-29 17:00:00 -0700

# what is 1/29/2013 plus two months?  easy!  march 29, 2013
(main)> jan_29_2013.delta(months:2)
=> 2013-03-29 17:00:00 -0600

# Yeah, smart guy?  Well then what is 1/29/2013 plus ONE month. It's Feb 28th.
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

# daylight savings!?  GEEZ dates are annoying
(main)> mar_10_2013 = NSDate.from_components

# unfortunately you will, in the edge cases, end up with stuff like this:
(main)> feb_28_2012 == feb_28_2012.delta(days:1, months:12).delta(days: -1, months:-12)
=> 2012-02-29 00:00:00 -0700
```

NSError
-------

`NSError.new` was just a mess, so I made it a legal method.

```ruby
NSError.new('Error Message')  # code: 0, domain: 'Error'
# with options
NSError.new('Error Message', code: 404)

# error messages ('Error Message' in this example) are stored in a Hash with the
# key 'NSLocalizedDescriptionKey'. If you pass a `userInfo` option, it will get
# merged with this array.  So you can ignore that ugly-looking key.
NSError.new('Error Message', code: 404, userInfo: { warnings: ['blabla'] })
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
"pattern".uicolor == "pattern".uiimage.uicolor  # => UIColor.colorWithPatternImage(UIImage.imageNamed("pattern"))

# UIFont from name
"my_font".uifont # => UIFont.fontWithName("my_font", size:UIFont.systemFontSize)
"my_font".uifont(20) # => UIFont.fontWithName("my_font", size:20)

# UIColor from image name or hex code
"pattern".uicolor # => UIColor.colorWithPatternImage(UIImage.imageNamed('pattern'))
"#ff00ff".uicolor == :fuchsia.uicolor == 0xff00ff.uicolor # => UIColor.colorWithRed(1.0, green:0.0, blue:1.0, alpha:1.0)
"#f0f".uicolor(0.5) == :fuchsia.uicolor(0.5) == 0xff00ff.uicolor(0.5) # => UIColor.colorWithRed(1.0, green:1.0, blue:1.0, alpha:0.5)
# note: 0xf0f.uicolor == 0x000f0f.uicolor.  There's no way to tell the difference
# at run time between those two Fixnum literals.

# NSLocalizedString from string
"hello".localized  # => NSBundle.mainBundle.localizedStringForKey("hello", value:nil, table:nil)
"hello"._          # == "hello".localized
"hello".localized('Hello!', 'hello_table')  # => ...("hello", value:'Hello!', table:'hello_table')

# file operations
"my.plist".exists?   # => NSFileManager.defaultManager.fileExistsAtPath("my.plist")
"my.plist".document  # => NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0].stringByAppendingPathComponent("my.plist")
"my.plist".cache  # => NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)[0].stringByAppendingPathComponent("my.plist")
"my.plist".remove!  # => NSFileManager.defaultManager.removeItemAtPath("my.plist".document, error: error)  (returns error, if any occurred)

# get the resource path, useful if you include json files or images you manipulate in the app
"my.plist".resource  # => NSBundle.mainBundle.resourcePath.stringByAppendingPathComponent("my.plist")
# same, but get a URL instead - often used to display a static HTML page that is stored in resources
"index.html".resource_url  # => NSBundle.mainBundle.URLForResource("index", withExtension:"html")

# access data from Info.plist
"CFBundleVersion".info_plist  # => NSBundle.mainBundle.infoDictionary["CFBundleVersion"]

# NSURL
"https://github.com".nsurl  # => NSURL.URLWithString("https://github.com")

# check if string is not a number
"pi".nan? # => NSNumberFormatter.alloc.init.numberFromString("pi").nil?
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

# these are really handy for custom buttons - touch_start means the finger is inside the button, touch_stop is outside the button or canceled
:touch_start  # => UIControlEventTouchDown | UIControlEventTouchDragEnter
:touch_stop   # => UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchDragExit

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

###### Image Manipulation - VERY handy!

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

# Combine two images
image_ab = image_a << image_b
```

#### 568

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

UIAlertView
--------

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

UIActionSheet
--------

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

 UIColor
---------

Methods to merge or manipulate a color, or to get information about a color.
Works best on RGB colors, but HSB will work well, too.  `UIColor`s based on
image patterns can't easily be inverted or mixed.

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
:white.uicolor.mix_with(:black.uicolor, 0.5)  # => :gray, same as :white + :black
:white.uicolor.mix_with(:black.uicolor, 0.75)  # => 0xbfbfbf.uicolor
:white.uicolor.mix_with(:black.uicolor, 1)  # => :black
```

 UIView
--------

```ruby
UIView.first_responder  # => returns the first responder, starting at UIApplication.sharedApplication.keyWindow
my_view.first_responder  # => also returns the first responder, but starts looking in my_view
my_view.controller  # => returns the UIViewController that this view belongs to
self.view << subview  # => self.view.addSubview(subview)
self.view.show  # => self.hidden = false
self.view.hide  # => self.hidden = true

# convert to UIImage.  retina-ready.
my_view.uiimage
# that will use the `bounds` property to size the image.  but if you want a
# screen shot of the contents of a scroll view, pass in `true` or `:all` to this
# method.
my_scroll_view.uiimage(:all)
```

When defining a UIView subclass, you often have attributes that affect your
`drawRect` method (99% of the time, ALL the attributes affect drawing, right?).
So SugarCube adds a `attr_updates` method, which creates an attribute identical
to `attr_accessor` but the setter calls setNeedsDisplay if the new value != the
old value.

```ruby
class NiftyView < UIView
  attr_updates :insets, :pattern

  def drawRect(rect)
    # ...
  end
end

nifty_view.pattern = 'my_pattern'  # => setNeedsDisplay gets called
nifty_view.pattern = 'my_pattern'  # => setNeedsDisplay doesn't get called, because the value didn't change.
```

###### Animations

jQuery-like animation methods.  They accept a "completed" callback handler that
accepts an optional 'completed' boolean (the
`UIView.animateWithDuration(delay:options:animations:completion:)`) method
provides it to all its completion handlers).

```ruby
# default timeout is 0.3
view.fade_out

# with a callback
view.fade_out {
  view.removeFromSuperview
}

# and the completed argument
view.fade_out { |completed|
  view.removeFromSuperview
}

# fade_out options
view.fade_out(duration: 0.5,
                 delay: 0,
               options: UIViewAnimationOptionCurveLinear,
               opacity: 0.5) {
  view.removeFromSuperview
}

view.move_to([0, 100])   # move to position 0, 100
view.delta_to([0, 100])  # move over 0, down 100, from current position

view.rotate_to Math::PI  # rotate view upside down
view.rotate 45.degrees  # rotate *an additional* 45 degrees
view.rotate_to(duration: 0.5, angle: 45.degrees)  # using options

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
view.shake offset: 0.1, repeat: 2, duration: 0.5, keypath: 'transform.rotation'

# this was pulled off warrenm's AHAlertView project.  I thought the effect was
# awesome, and deserved more attention!
# https://github.com/warrenm/AHAlertView
view.tumble  # the view will fall and rotate - a good 'cancel button effect'
```

Using the completed callback you can string animations together for a low-tech
animation sequence.

```ruby
view.slide(:left, 20) {
  view.slide(:up, 20) {
    view.slide(:right, 20) {
      view.slide(:down, 20) {
        view.fade_out
      }
    }
  }
}
```

Those be some gnarly callbacks.  You can write this as a chain instead!

```ruby
UIView.animation_chain {
  view.slide(:left, 20)
}.and_then {
  view.slide(:up, 20)
}.and_then {
  view.slide(:right, 20)
}.and_then {
  view.slide(:down, 20)
}.and_then {
  view.fade_out
}.start
```

Behind the scenes, any calls to a SugarCube animate method (`slide`, `fade`,
`rotate`) will be setup to run *immediately* instead of in a
`UIView#animateWithDuration(...)` block.  You can also do multiple animations
within that block, as long as no two animations affect the same property:

```ruby
UIView.animation_chain {
  view.slide(:left, 20)
  view.rotate(90.degrees)
}.and_then {
  view.slide(:up, 20)
  view.rotate(90.degrees)
}.and_then {
  view.slide(:right, 20)
  view.rotate(90.degrees)
}.and_then {
  view.slide(:down, 20)
  view.rotate(90.degrees)
}.and_then {
  view.fade_out
  view.rotate_to(0.degrees)
}.start
```

Chains can also be written like this:

```ruby
chain = UIView.animation_chain
chain << proc { view.slide(:left, 20) }
chain << proc { view.slide(:up, 20) }
chain << proc { view.slide(:right, 20) }
chain << proc { view.slide(:down, 20) }
chain << proc { view.fade_out }
chain.start
```

**AND** chains can be looped!  Either number of times, or call `stop` on the
chain.

```ruby
chain = UIView.animation_chain {
  view.slide(:left, 20)
}.and_then {
  view.slide(:right, 20)
}.loop  # loop forever
2.seconds.later { chain.stop }  # the animation will complete, but not loop again
chain.loop(10)  # would loop 10 times

# if you're impatient
chain.abort
# will stop the animation at the end of whatever block it is in, so it could be
# in a strange position, depending on where in the chain it is.  better to call
# `stop`
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

###### UISegmentedControl

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
verbs and SugarCube symbols.

```ruby
button = UIButton.alloc.initWithFrame([0, 0, 10, 10])

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
present_modal(view_ctlr) { puts "Now You See Me!" }
dismiss_modal { puts "Now You Don't!" }
```

If you like these methods, but you want to specify the reciever, they are
re-defined on `UIViewController` for this purpose:

```ruby
controller.present_modal(other_controller) { puts "presented" }
```

 UINavigationController
------------------------

`push`, `<<` and `pop` instead of `pushViewController` and `popViewController`.

animated is `true` for all these.

`pop` accepts an argument: either a view controller to pop to, or the symbol
`:root` which does what you might expect

```ruby
nav_ctlr << root_ctlr
# or nav_ctlr.push(root_ctlr)
nav_ctlr << new_ctlr
# ... imagine we push on a ton of controllers ...
nav_ctlr << another_ctlr
nav_ctlr << last_ctlr
nav_ctlr.pop # => pops to another_ctlr, because it's next on the stack
nav_ctlr.pop new_ctlr # => pops to new_ctlr
nav_ctlr.pop :root  # => pops to root_ctlr, because it's on the bottom
```

 UITabBarController
------------------------

I have mixed feelings about adding this extension, but **I** needed it, so maybe
you will, too...  Usually a `UITabBarController` has a static number of tabs,
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

 UILabel
----------

 Added simple `fit_to_size` function to the label, which will start at the supplied font size
 and then squeeze down until all the text fits.  This way you can assure any dynamic text will completely display
 in a given label frame.

 The font size changes instead of the frame size.
 ```ruby
 #this will try to make the containing text fit at font size 40, but squeeze as needed.
@label.fit_to_size(40)
puts @label.font.pointSize # => Will be 40 or less depending on the font type and label frame.
 ```

 UIBarButtonItem
----------------------

```ruby
# Get an instance containing the specified system item.
UIBarButtonItem.done {
  self.dismissViewControllerAnimated true, completion:nil
}
# =>
UIBarButtonItem.alloc.initWithBarButtonSystemItem(:done.uibarbuttonitem, target:self, action:"action:")
# with 'action' defined as:
def action(sender)
  self.dismissViewControllerAnimated true, completion:nil
end

# the method names are 1::1 with the uibarbuttonitem constants in symbol.rb
UIBarButtonItem.cancel(&action)           => UIBarButtonItem.alloc.initWithBarButtonSystemItem(:cancel.uibarbuttonitem, target:self, action:"action:")
UIBarButtonItem.edit(&action)             => UIBarButtonItem.alloc.initWithBarButtonSystemItem(:edit.uibarbuttonitem, target:self, action:"action:")
UIBarButtonItem.save(&action)             => UIBarButtonItem.alloc.initWithBarButtonSystemItem(:save.uibarbuttonitem, target:self, action:"action:")
  .
  .
  .
UIBarButtonItem.pagecurl(&action)         => UIBarButtonItem.alloc.initWithBarButtonSystemItem(:pagecurl.uibarbuttonitem, target:self, action:"action:")

# Get an instance containing the specified title.
UIBarButtonItem.titled('Close') {
  self.dismissViewControllerAnimated true, completion:nil
}
# =>
UIBarButtonItem.alloc.initWithTitle('Close', style: :bordered.uibarbuttonstyle, target:self, action:"action:")

def action:sender
  self.dismissViewControllerAnimated true, completion:nil
end

# You can also specify a style.
UIBarButtonItem.titled('Close', :plain.uibarbuttonstyle) {
  self.dismissViewControllerAnimated true, completion:nil
}


# Get an instance containing the specified image.
UIBarButtonItem.imaged('close'.uiimage) {
  self.dismissViewControllerAnimated true, completion:nil
}
# =>
UIBarButtonItem.alloc.initWithImage('Close'.uiimage, style: :bordered.uibarbuttonstyle, target:self, action:"action:")
def action:sender
  self.dismissViewControllerAnimated true, completion:nil
end

# You can also specify a style.
UIBarButtonItem.imaged('close'.uiimage, :plain.uibarbuttonstyle) {
  self.dismissViewControllerAnimated true, completion:nil
}

# Get an instance containing the specified array which contains a portrate image and a landscape iamge.
UIBarButtonItem.imaged(['portrate'.uiimage, 'landscape'.uiimage) {
  self.dismissViewControllerAnimated true, completion:nil
}
# =>
UIBarButtonItem.alloc.initWithImage('portrate'.uiimage, landscapeImagePhone:'landscape'.uiimage, style: :bordered.uibarbuttonstyle, target:self, action:"action:")
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

# might as well make an alias
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
# **really** define them this way (go back to python if you find your brain
# hemorrhaging):
1.month   || 2.months   # 1.month = 30 days
1.year    || 2.years    # 1.year = 365 days

# some comparison methods
date1.today?
date2.same_day? date1
```

NSUserDefaults
----------------

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

 CoreLocation
--------------

Open up `CLLocationCoordinate2D` to provide handy-dandies

```ruby
> denver_co = CLLocationCoordinate2D.new(39.739188,-104.985223)
=> #<CLLocationCoordinate2D latitude=39.7391815185547 longitude=-104.985198974609>
> loveland_oh = CLLocationCoordinate2D.new(39.268128,-84.257648)
=> #<CLLocationCoordinate2D latitude=39.2681274414062 longitude=-84.2576293945312>
> denver_co.distance_to(loveland_oh)
=> 1773425.5  # in meters
> denver_co.distance_to(loveland_oh).miles
=> 1101.955078125
> denver_co.delta_miles(1101.6, -32.556)
=> #<CLLocationCoordinate2D latitude=39.2681427001953 longitude=-84.2577209472656>
> denver_co.delta_miles(1101.6, -32.556).distance_to(loveland_oh)
=> 8.0804328918457   # this is in meters
> denver_co.delta_miles(1101.6, -32.556).distance_to(loveland_oh).miles
=> 0.00502094626426697
```

 REPL View adjustments
-----------------------

Pixel pushing is an unfortunate but necessary evil.  Well, at least we can make
it a little less painful.  SugarCube provides a library that adds some methods
that are meant to be used in the REPL.

`require "sugarcube-repl"`

The actual code is, for historical reasons, in the `SugarCube::Adjust` module,
which is included by default.  But to really be handy you'll want to require the
`sugarcube-repl` package.

#### Finding the view you want.

This is often touted as the *most useful feature* of SugarCube!

```
(main)> tree
  0: . UIWindow(#6e1f950: [[0.0, 0.0], [320.0, 480.0]])
  1: `-- UIView(#8b203b0: [[0.0, 20.0], [320.0, 460.0]])
  2:     +-- UIButton(#d028de0: [[10.0, 10.0], [320.0, 463.400512695312]])
  3:     |   `-- UIImageView(#d02aaa0: [[0.0, 0.0], [320.0, 463.400512695312]])
  4:     +-- UIRoundedRectButton(#d02adb0: [[55.0, 110.0], [210.0, 20.0]])
  5:     |   `-- UIButtonLabel(#d02af00: [[73.0, 0.0], [63.0, 19.0]], text: "Button 1")
  6:     +-- UIRoundedRectButton(#d028550: [[60.0, 30.0], [200.0, 20.0]])
  7:     |   `-- UIButtonLabel(#d02afb0: [[68.0, 0.0], [63.0, 19.0]], text: "Button 2")
  8:     `-- UIRoundedRectButton(#d02b220: [[70.0, 30.0], [300.0, 20.0]])
  9:         `-- UIButtonLabel(#d02b300: [[118.0, 0.0], [63.0, 19.0]], text: "Button 3")
```

SugarCube provides lot of `to_s` methods on UIKit objects - that is so that this
tree view is really easy to find the view you want.  Once you do find the one
you want, you can fetch it out of that list using the `adjust` method, which is
aliased to `a` to make it easy on the fingers.

```
(main)> a 6
=> UIRoundedRectButton(#d028550: [[60.0, 30.0], [200.0, 20.0]]), child of UIView(#8b203b0)
```

Now that we've chose the button, it is available in the `a` method, *and* there
are a bunch of methods in the SugarCube::Adjust module that act on that object.
Most of these methods help you adjust the frame of a view.

```ruby
> up 1
> down 1  # same as `up -1`
> down  # defaults to 1 anyway
> left 10
> right 10
> left  # => left 1
> origin 10, 12  # move to x:10, y:12
> wider 15
> thinner 10
> taller  # => taller 1
> shorter  # => shorter 1
> size 100, 10  # set size to width:100, height: 10
> shadow(opacity: 0.5, offset: [0, 0], color: :black, radius: 1)  # and path, which is a CGPath object.
> center  # See `Centering` section below
> restore  # original frame and shadow is saved when you first call `adjust`
```

Here are the short versions of those methods.

```ruby
> u          # up, default value=1
> d          # down
> l          # left
> r          # right
> w          # wider
> n          # thiNNer
> t          # taller
> s          # shorter
> o 10, 12   # origin
> o [10, 12]
> o CGPoint.new(10, 12)
> o Point(10, 12)
> z 100, 10  # siZe, also accepts an array, CGSize, or Size()
             # and frame
> f [[0,0], [0,0]]
             # sHadow
> h opacity: 0.5, offset: [0, 0], color: :black, radius: 1

# frame, size, origin, and shadow can also be used as getters
> f
[[0, 0], [320, 568]]
> o          # origin
[0, 0]
> z          # size
[320, 568]
> h          # this returns an object identical to what you can pass to `shadow`
{opacity: 0.5, offset: [0, 0], color: :black, radius: 1}

# and of course the `a` method returns the current object
> a
=> UITextField(#9ce6470, [[46, 214], [280, 33]], text: "hi!"), child of UIView(#10a6da20)
```

The most useful feature of the REPL adjustment is the ability to quickly
position and size your UI elements __visually__ and then paste the final values
into your code.  In order to better accomodate that, `adjust` has an option to
modify the output format.  Many thanks to [Thom Parkin][] for developing these
output formatters.

```
(main)> repl_format :ruby
```

Currently supported is:

* RubyMotion (Default) (`:ruby`)
* Objective-C (`:objc`)
* JSON (`:json`)

#### Objective-C style

```
(main)> repl_format :objc
(main)> tree
  0: . UIWindow(#6e27180: {{0, 0}, {320, 480}})
  1: `-- UIView(#8d631b0: {{0, 20}, {320, 460}})
  2:     +-- UIButton(#6d6c090: {{10, 10}, {320, 463.401}})
  3:     |   `-- UIImageView(#8d67e00: {{0, 0}, {320, 463.401}})
  4:     `-- UIRoundedRectButton(#8d68170: {{10, 30}, {30, 200}})
  5:         `-- UIButtonLabel(#8d69c30: {{2, 90}, {26, 19}})
=> UIWindow(#6e27180, {{0, 0}, {320, 480}},

# you can pass the format into the adjust method:
(main)> a 4, :objc
=> "UIRoundedRectButton(#8d68170: {{10.0, 30.0}, {200.0, 30.0}})"

# it will continue to be used in subsequent calls
(main)> wider 15
{{10.0, 30.0}, {200.0, 45.0}}
=> "UIRoundedRectButton(#8d68170: {{10.0, 30.0}, {200.0, 45.0}}) child of UIView(#8d631b0)"
```

#### JSON (or GeoMotion)

```
(main)> a 1, :json
=> "UIView(#8d631b0: {x: 0.0, y: 20.0, height: 460.0, width: 320.0})"
(main)> wider 30
=> "CGRect(#6e9c9f0: {x: 0.0, y: 20.0, height: 460.0, width: 350.0})"
(main)> right 130
=> "CGRect(#8dc6a40: {x: 130.0, y: 20.0, height: 460.0, width: 350.0})"
(main)> tree
  0: . UIWindow(#6e27180: {x: 0.0, y: 0.0, height: 480.0, width: 320.0})
  1: `-- UIView(#8d631b0: {x: 130.0, y: 20.0, height: 460.0, width: 350.0})
  2:     +-- UIButton(#6d6c090: {x: 10.0, y: 10.0, height: 463.400512695312, width: 320.0})
  3:     |   `-- UIImageView(#8d67e00: {x: 0.0, y: 0.0, height: 463.400512695312, width: 320.0})
  4:     `-- UIRoundedRectButton(#8d68170: {x: 10.0, y: 30.0, height: 200.0, width: 45.0})
  5:         `-- UIButtonLabel(#8d69c30: {x: 4.0, y: 90.0, height: 19.0, width: 37.0})
=> UIWindow(#6e27180: {x: 0.0, y: 0.0, height: 480.0, width: 320.0})
```

###  CENTER (in parent frame)

It is called as `center(which_index, of_total_number, direction)`. The order can
be changed, and all the arguments are optional.  Default values are
`center(1, 1, 'h')` (center the item horizontally).

You can set 'direction' using a string or symbol: 'horiz', 'vert', 'x', even 'x
and y'.  The method searches for the letters `[xyhv]`.

Here are a few examples:

```
(main)> center
[[145.0, 30.0], [30.0, 200.0]]
UIRoundedRectButton.origin = [145.0, 30.0]
=> "[[145.0, 30.0], [30.0, 200.0]]"
```

In order to place that same button in the center of the screen - horizontally
and vertically - you can use this shorthand syntax:

`center :xy`

If you have three buttons and want them spaced evenly (vertically) across their
parent frame, you can accomplish that this way:

```
(main)> tree
  0: . UIWindow(#6e1f950: [[0.0, 0.0], [320.0, 480.0]])
  1: `-- UIView(#8b203b0: [[0.0, 20.0], [320.0, 460.0]])
  2:     +-- UIButton(#d028de0: [[10.0, 10.0], [320.0, 464]])
  3:     |   `-- UIImageView(#d02aaa0: [[0.0, 0.0], [320.0, 464]])
  4:     +-- UIRoundedRectButton(#d02adb0: [[55.0, 110.0], [210.0, 20.0]], text: "Button 1")
  5:     |   `-- UIButtonLabel(#d02af00: [[73.0, 0.0], [63.0, 19.0]])
  6:     +-- UIRoundedRectButton(#d028550: [[60.0, 30.0], [200.0, 20.0]], text: "Button 2")
  7:     |   `-- UIButtonLabel(#d02afb0: [[68.0, 0.0], [63.0, 19.0]])
  8:     `-- UIRoundedRectButton(#d02b220: [[70.0, 30.0], [300.0, 20.0]], text: "Button 3")
  9:         `-- UIButtonLabel(#d02b300: [[118.0, 0.0], [63.0, 19.0]])
=> UIWindow(#6e1f950, [[0.0, 0.0], [320.0, 480.0]])
# grab the first button, and center it vertically.  It is the first of three buttons
(main)> a 4; center 1, 3, :vert; center
[[55.0, 110.0], [210.0, 20.0]]
UIRoundedRectButton.origin = [55.0, 110.0]
=> "[[55.0, 110.0], [210.0, 20.0]]"
# grab the second button.  The first parameter changes to `2`, because this
# button is in the second position.
(main)> a 6; center 2, 3, :vert; center
[[60.0, 220.0], [200.0, 20.0]]
UIRoundedRectButton.origin = [60.0, 220.0]
=> "[[60.0, 220.0], [200.0, 20.0]]"
# grab the third button and place it in the third position
(main)> a 8; center 3, 3, :vert; center
[[10.0, 330.0], [300.0, 20.0]]
UIRoundedRectButton.origin = [10.0, 330.0]
=> "[[10.0, 330.0], [300.0, 20.0]]"
```

The calculated positions (x,y) are in the REPL output

#### Finding the *[controller,layer,...]* you want.

**Don't stop there!**

You can analyze `UIViewController` and `CALayer` hierarchies, too.  There's even
a handy `root` method to grab the `rootViewController`:

```ruby
(main)> tree root
  0: . #<MainScreenController:0xac23b80>
  1: +-- #<ScheduleViewController:0x13185d00>
  2: |   +-- #<ScheduleTableController:0x131862f0>
  3: |   `-- #<ScheduleCalendarController:0x131bba90>
  4: +-- #<CameraViewController:0x13191380>
  5: +-- #<UINavigationController:0xac01ea0>
  6: |   `-- #<UITableViewController:0xac04e30>
  7: +-- #<PicturesViewController:0x1403ede0>
  8: `-- #<MessagesViewController:0x131a1bc0>
=> #<MainScreenController:0xac23b80>
```

If you have a tree structure and you want to output it using `tree`, you can do
so by passing either a method name (that should return an array) or a block. The
block will be passed your object, and should return the children.

```ruby
class Foo
  attr_accessor :children
end
```
```
(main)> foo = Foo.new
(main)> foo.children = [Foo.new,Foo.new,Foo.new]
(main)> tree foo, :children
(main)> tree foo, :children
  0: . #<Foo:0x12d6e0d0>
  1: +-- #<Foo:0x114146c0>
  2: +-- #<Foo:0x114149d0>
  3: `-- #<Foo:0x114149e0>

=> #<Foo:0x12d6e0d0 @children=[#<Foo:0x114146c0>, #<Foo:0x114149d0>, #<Foo:0x114149e0>]>
(main)> tree(foo) { |f| f.children }
  0: . #<Foo:0x12d6e0d0>
  1: +-- #<Foo:0x114146c0>
  2: +-- #<Foo:0x114149d0>
  3: `-- #<Foo:0x114149e0>

=> #<Foo:0x12d6e0d0 @children=[#<Foo:0x114146c0>, #<Foo:0x114149d0>, #<Foo:0x114149e0>]>
```

##### Global objects

The adjust and tree methods act on global objects.  Once either of these methods
is used, you can access that global if you want:

```ruby
$sugarcube_view  # => the view (or any object) being 'adjusted' (accessible using `adjust` or `a`)
$sugarcube_items  # => the list of views that was output using `tree`
```


 Pointers
----------

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

 Ruby on Rails Ripoffs (RoR-R?)
---------------

aka `ActiveSupport`.

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

# and my favorite
1.in? [1,2,3]  # => true
1.in? 1,2,3    # => true
1.in? 4..5     # => false
```

Gestures
--------

Sugarcube's gesture support is very similar to BubbleWrap's, and it's entirely
possible that the two will be merged into one thing.  But SugarCube is all about
extending base classes, whereas BubbleWrap tends to add *new* classes to do the
heavy lifting.  Plus the options you pass to SugarCube are very different, and
the prefix is "on" instead of "when" (e.g. "on_pan" instead of "when_panned")

Gestures are an "opt-in" extension.  In your Rakefile, add
`require 'sugarcube-gestures'`.

```ruby
require 'sugarcube-gestures'

view.on_pan { |gesture|
  location = gesture.view.locationInView(view)
}

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

view.on_press   # use system defaults
view.on_press(1.5)  # duration
view.on_press(duration: 1.5, taps: 1, fingers: 1)
```

 Unholy
--------

These methods are just about as opinionated as they get - even more than the RoR
additions.  They are not included by default, so please don't freak out about
them.  I add them here because I don't think anyone will notice if I do, and I
use these everywhere. :poop:

### `ivar`

###### Rakefile

```ruby
require 'sugarcube-unholy'
```

###### Elsewhere

```ruby
class Baz ; end
foo = Baz.new

# (:symbol || 'string').ivar
foo.instance_variable_set(:bar.ivar, value)  # => foo.instance_variable_set(:@bar, value)
foo.instance_variable_set(var_name.ivar, value)  # => foo.instance_variable_set("@#{var_name}", value)

# (:symbol || 'string').cvar
Baz.class_variable_set(var_name.cvar, value)  # => Baz.class_variable_set("@@#{var_name}", value)
```

[BubbleWrap]: https://github.com/rubymotion/BubbleWrap
[sweettea]: https://github.com/colinta/sweettea
[teacup]: https://github.com/rubymotion/teacup
[nsnulldammit]: https://github.com/colinta/nsnulldammit
[geomotion]: https://github.com/clayallsopp/geomotion

[Fusionbox]: http://www.fusionbox.com/
[fusionbox announcement]: http://fusionbox.org/projects/rubymotion-sugarcube/
[Clay Allsopp]: https://github.com/clayallsopp
[Thom Parkin]: https://github.com/ParkinT
