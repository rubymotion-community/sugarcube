describe "UILabel" do

	it 'should have a #fit_to_size method' do
		@label = UILabel.alloc.initWithFrame([[10, 10], [200, 40]])
		@label.text = "Timeo Danaos et dona ferentes" * 10
		@label.numberOfLines = 0
		@label.fit_to_size(40)

		@label.font.pointSize.should < 40
		@label.font.pointSize.should > 0
	end
end