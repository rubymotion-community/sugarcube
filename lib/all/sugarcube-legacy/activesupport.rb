# Thanks ruby on rails!
#
# These are all blatent, unapologetic rip offs of RoR extensions, and they
# behave in exactly the same way.

class Object

  def blank?
    respond_to?(:empty?) ? empty? : !self
  end

  def present?
    !blank?
  end

  # okay, this is strange, but `rake spec` fails if I define the method as `in?`
  # but passes if I alias it, as I do below.  weird, but I don't want to fight
  # it.
  def __in_workaround(args)
    args.include?(self)
  rescue NoMethodError
    raise ArgumentError.new("The parameter passed to #in? must respond to #include?")
  end
  alias in? __in_workaround

end
