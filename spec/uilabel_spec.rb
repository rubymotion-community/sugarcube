describe "UILabel" do

	it 'should have a #fit method' do
		@label = UILabel.alloc.initWithFrame([[10, 10], [200, 40]])
		@label.text = "Timeo Danaos et dona ferentes"
		@label.numberOfLines = 0
		@label.fit(40)

		@label.font.pointSize.should <= 40
		@label.font.pointSize.should > 0
	end
end