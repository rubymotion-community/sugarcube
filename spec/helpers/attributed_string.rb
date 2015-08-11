class Should
  def have_string_attributes(attributes)
    @object.should.be.kind_of(NSAttributedString)
    has_attrs = @object.attributesAtIndex(0, effectiveRange: nil)
    attributes.each do |key, value|
      has_attrs[key].should == attributes[key]
    end
  end
end
