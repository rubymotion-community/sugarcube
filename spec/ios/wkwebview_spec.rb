describe "Sugarcube::WebView" do

  describe WKWebView do
    tests UIViewController

    before do
      @view = UIView.alloc.initWithFrame([[1,2],[3,4]])
      controller.view.addSubview(@view)

      @webview = WKWebView.alloc.init
      @view << @webview

      @webview.eval_js('') {|id, error| ;; }    # NOOP
    end

    after do
      @view = @webview = nil
    end

    [["1 + 1", 2.0],
     ["null", nil],
     ["(function(x) { return x * x; })(4)", 16.0]].each do |str, expected|
      it "should eval '#{str}'" do
        @res = ''

        @webview.eval_js(str) do |id, error|
          @res = id
        end

        wait 5.0 do
          @res.should == expected
        end
      end
    end

  end
end
