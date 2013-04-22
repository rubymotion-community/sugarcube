describe 'UIAlertView' do
  tests UIViewController

  it 'Should display "OK" when no buttons are specified' do
    alert = UIAlertView.alert('test') { @touched = true}
    alert.dismissWithClickedButtonIndex(0, animated: false)

    @touched.should == true
  end

end
