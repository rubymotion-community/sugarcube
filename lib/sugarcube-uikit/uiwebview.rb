class UIWebView

  def eval_js(str)
    self.stringByEvaluatingJavaScriptFromString str
  end

end
