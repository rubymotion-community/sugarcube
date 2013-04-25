describe "UIWebView" do

  [["1 + 1", "2"],
   ["null", ""],
   ["(function(x) { return x * x; })(4)", "16"]].each do |str, expected|
    it "should eval '#{str}'" do
      UIWebView.alloc.init.eval_js(str).should == expected
    end
  end

end
