# Factory methods for UITabBarItem. I've never understood why UITabBarItem makes
# it so easy to set the view tag, but these methods do not require you to do so.
class UITabBarItem

  class << self

    def titled(title, options={})
      tag = options.fetch(:tag, 0)
      image = options[:image]
      badge = options[:badge]
      if image && image.respond_to?(:uiimage)
        image = image.uiimage
      end
      selected_image = options[:selected_image]
      if selected_image && selected_image.respond_to?(:uiimage)
        selected_image = selected_image.uiimage
      end
      item = self.alloc.initWithTitle(title, image: image, selectedImage: selected_image)
      if tag
        item.tag = tag
      end
      if badge
        item.badgeValue = badge.to_s
      end
      return item
    end

    def system(type, options={})
      type = type.uitabbarsystemitem if type.respond_to?(:uitabbarsystemitem)
      tag = options.fetch(:tag, 0)
      badge = options[:badge]
      item = self.alloc.initWithTabBarSystemItem(type, tag: tag)
      if badge
        item.badgeValue = badge.to_s
      end
      return item
    end

    def more(options={})
      return self.system(UITabBarSystemItemMore, options)
    end

    def favorites(options={})
      return self.system(UITabBarSystemItemFavorites, options)
    end

    def featured(options={})
      return self.system(UITabBarSystemItemFeatured, options)
    end

    def top_rated(options={})
      return self.system(UITabBarSystemItemTopRated, options)
    end

    def recents(options={})
      return self.system(UITabBarSystemItemRecents, options)
    end

    def contacts(options={})
      return self.system(UITabBarSystemItemContacts, options)
    end

    def history(options={})
      return self.system(UITabBarSystemItemHistory, options)
    end

    def bookmarks(options={})
      return self.system(UITabBarSystemItemBookmarks, options)
    end

    def search(options={})
      return self.system(UITabBarSystemItemSearch, options)
    end

    def downloads(options={})
      return self.system(UITabBarSystemItemDownloads, options)
    end

    def most_recent(options={})
      return self.system(UITabBarSystemItemMostRecent, options)
    end

    def most_viewed(options={})
      return self.system(UITabBarSystemItemMostViewed, options)
    end

  end

end
