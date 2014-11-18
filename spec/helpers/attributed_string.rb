class Should
  def have_string_attributes(attributes)
    @object.should.be.kind_of(NSAttributedString)
    @object.attributesAtIndex(0, effectiveRange:nil).should == attributes
  end
end
