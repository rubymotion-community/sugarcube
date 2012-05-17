require 'delegate'


# this needs to be tested!
# the point here is to have the `percent` method available
# on Floats and Fixnums, but calling it many times returns the same number
#
#     100.percent => 1.0
#     99.25.percent => .9925
#     99.25.percent.percent => .9925
class Percent < DelegateClass(Float)

  def percent
    self
  end

end


class Float

  def percent
    Percent.new(self / 100.0)
  end

end
