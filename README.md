sugarcube
=========

Some sugar for your cocoa, or your tea.

examples
========

`Fixnum`
--------

```ruby
# create a UIColor from a hex value
0xffffff.uicolor # => UIColor.colorWithRed(green:,blue:,alpha:1.0)

# create a percentage
100.percent # => 1.00
55.percent # => 0.55
```

`Float`
-------

```ruby
# create a percentage
100.0.percent # => 1.00
55.0.percent # => 0.55
```

`String`
--------

```ruby
# UIImage from name
"my_image".uiimage # => UIImage.imageNamed("my_image")

# UIFont from name
"my_font".uifont # => UIFont.fontWithName("my_font", size:UIFont.systemFontSize)
"my_font".uifont(20) # => UIFont.fontWithName("my_font", size:20)

# UIColor from name OR image
"blue".uicolor == :blue.uicolor # => UIColor.blueColor
"my_image".uicolor == "my_image".uiimage.uicolor # => UIColor.colorWithPatternImage(UIImage.imageNamed("my_image"))
```

`Symbol`
--------

This is the "big daddy".  Lots of sugar here...

```ruby
:center.uialignment  # => UITextAlignmentCenter
:rounded.uibuttontype  # => UIButtonTypeRounded
:highlighted.uicontrolstate  # => UIControlStateHighlighted
:blue.uicolor  # UIColor.blueColor
# all CSS colors are supported.
# (no "grey"s, only "gray"s, consistent with UIKit, which only provides "grayColor")
:firebrick.uicolor  # => 0xb22222.uicolor
:bold.uifont  # UIFont.boldSystemFontOfSize(UIFont.systemFontSize)
:bold.uifont(10)  # UIFont.boldSystemFontOfSize(10)
:small.uifontsize # => UIFont.smallSystemFontSize
:small.uifont  # => UIFont.systemFontOfSize(:small.uifontsize)
:bold.uifont(:small)  # UIFont.boldSystemFontOfSize(:small.uifontsize)
```

`UIImage`
---------

```ruby
image = "my_image".uiimage
image.uicolor # => UIColor.colorWithPatternImage(image)
```

`UIView`
--------

```ruby
self.view << subview  # => self.view.addSubview(subview)
```
