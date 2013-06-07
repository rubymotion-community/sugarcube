class Numeric

  def bytes
    self
  end
  alias byte bytes

  def kilobytes
    self * 1024**1
  end
  alias kilobyte kilobytes

  def megabytes
    self * 1024**2
  end
  alias megabyte megabytes

  def gigabytes
    self * 1024**3
  end
  alias gigabyte gigabytes

  def terabytes
    self * 1024**4
  end
  alias terabyte terabytes

  def petabytes
    self * 1024**5
  end
  alias petabyte petabytes

  def exabytes
    self * 1024**6
  end
  alias exabyte exabytes

end
