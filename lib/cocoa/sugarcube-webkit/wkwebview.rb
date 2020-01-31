module SugarCube
  # Evaluating javascript from string
  module WebView

    def eval_js(str, &block)
      self.evaluateJavaScript(str, completionHandler:->(id, error){ block.call(id, error) })
    end

  end
end
