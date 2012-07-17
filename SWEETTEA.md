sweettea
========

    teacup + sugarcube = sweettea


 handlers
----------

Handlers for teacup that add the coercion abilities of sugarcube to the style
abilities of teacup, for great good.

```ruby
# what was
my_image = UIImage.imageNamed("Logo")
style :label,
  font: UIFont.fontWithName("Inconsolata", size:UIFont.systemFontSize),
  image: my_image,
  origin: [10, 10],
  size: my_image.size

# sugarcube
my_image = "Logo".uiimage
style :label,
  font: "Inconsolata".uifont,
  image: my_image,
  origin: [10, 10],
  size: my_image.size

# sweettea
style :label,
  font: "Inconsolata",
  image: "Logo",
  origin: [10, 10]
  # size is set automatically, isn't that nice?
  # (it will not be set if frame.size is already set to something other than [0, 0])
```

 classes
---------

tiny tiny useful classes, like if you want to have an imageview with stuff on it
(sets `userInteractionEnabled` to true) or an image button, or a full screen
view without caring to check the device.

```ruby
subview(UIButton.custom, bg_image: "image name")
subview(STFullScreenView) do
end
subview(STInteractiveImageView, image: "backrgound") do
  subview(UITextField, :name)
end
```

 installation
--------------

    gem install sugarcube

    # or in Gemfile
    gem 'sugarcube'

    # in Rakefile
    require 'sugarcube'
    require 'sugarcube-sweettea'
