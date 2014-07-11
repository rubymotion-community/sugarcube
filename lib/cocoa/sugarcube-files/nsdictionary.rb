class NSDictionary

  class << self

    def read_from(path_or_url)
      case path_or_url
      when NSURL
        self.dictionaryWithContentsOfURL(path_or_url)
      when NSString
        self.dictionaryWithContentsOfFile(path_or_url)
      else
        false
      end
    end

  end

  def write_to(path_or_url, atomically=true)
    case path_or_url
    when NSURL
      self.writeToURL(path_or_url, atomically: atomically)
    when NSString
      self.writeToFile(path_or_url, atomically: atomically)
    else
      false
    end
  end

end
