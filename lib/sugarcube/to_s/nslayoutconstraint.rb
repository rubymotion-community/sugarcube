if defined? NSLayoutConstraint
class NSLayoutConstraint
  Relationships = {
    equal: NSLayoutRelationEqual,
    lte: NSLayoutRelationLessThanOrEqual,
    gte: NSLayoutRelationGreaterThanOrEqual,
  }
  Attributes = {
    left: NSLayoutAttributeLeft,
    right: NSLayoutAttributeRight,
    top: NSLayoutAttributeTop,
    bottom: NSLayoutAttributeBottom,
    leading: NSLayoutAttributeLeading,
    trailing: NSLayoutAttributeTrailing,
    width: NSLayoutAttributeWidth,
    height: NSLayoutAttributeHeight,
    center_x: NSLayoutAttributeCenterX,
    center_y: NSLayoutAttributeCenterY,
    baseline: NSLayoutAttributeBaseline,
  }

  def to_s
    target = firstItem
    relative_to = secondItem

    if firstItem and secondItem
      if secondItem == firstItem
        relative_to = :self
      elsif firstItem.superview and secondItem == firstItem.superview
        relative_to = :superview
      elsif secondItem.respond_to?(:stylename) and secondItem.stylename
        relative_to = secondItem.stylename
      end

      if secondItem.superview and firstItem == secondItem.superview
        target = :superview
      elsif firstItem.respond_to?(:stylename) and firstItem.stylename
        target = firstItem.stylename
      end
    elsif firstItem
      if firstItem.respond_to?(:stylename) and firstItem.stylename
        target = firstItem.stylename
      end
    elsif secondItem
      if secondItem.respond_to?(:stylename) and secondItem.stylename
        target = secondItem.stylename
      end
    end

    op = case _to_s_relationship_reverse relation
         when :equal
           '=='
         when :gte
           '>='
         when :lte
           '<='
         end
    formula = 'first.'
    formula << _to_s_attribute_reverse(firstAttribute).to_s
    formula << ' ' << op << ' '
    if multiplier != 1
      formula << multiplier.to_s << ' × '
    end
    if secondItem
      if firstItem == secondItem
        formula << 'first.'
      else
        formula << 'second.'
      end
      formula << _to_s_attribute_reverse(secondAttribute).to_s
    end
    if constant != 0
      if secondItem
        formula << ' + '
      end
      formula << constant.to_s
    end

    return "#<#{self.class}:##{object_id.to_s(16)}" +
           " firstItem=#{target.inspect}" +
           " secondItem=#{relative_to.inspect}" +
           " priority=#{priority.inspect}" +
           " formula=#{formula.inspect}" +
           ">"
  end

private
  def _to_s_attribute_reverse(attribute)
    Attributes.key(attribute) || :none
  end

  def _to_s_relationship_reverse(relationship)
    Relationships.key(relationship)
  end

end
end