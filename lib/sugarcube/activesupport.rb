# thanks ruby on rails!
#
# these are all blatent, unapologetic rip offs of RoR extensions.

class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end

  def present?
    !blank?
  end
end
