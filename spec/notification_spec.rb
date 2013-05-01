class NotificationsTester
  attr :notification
  attr :object

  def reset!
    @notified = nil
    @notification = nil
    @object = nil
  end

  def notified?
    @notified
  end

  def BAM(notification)
    @notified = true
    @notification = notification
    @object = notification.object
  end

end

describe "Notifications" do

  before do
    @notification = 'NotificationName'
    @object = 'specific object'
    @notification_tester = NotificationsTester.new
    @notification_tester_object = NotificationsTester.new

    @notification.add_observer(@notification_tester, :'BAM:')
    @notification.add_observer(@notification_tester_object, :'BAM:', @object)
  end

  it "should post and receive notification" do
    @notification_tester.reset!
    @notification_tester_object.reset!

    @notification.post_notification
    @notification_tester.notified?.should == true
    @notification_tester.notification.should != nil
    @notification_tester.object.should == nil

    @notification.post_notification(@object)
    @notification_tester_object.notified?.should == true
    @notification_tester_object.notification.should != nil
    @notification_tester_object.object.should == @object
  end

  describe "should send userInfo" do
    it 'should return values' do
      @notification.post_notification(@object, key: :value)
      @notification_tester_object.notified?.should == true
      @notification_tester_object.notification.should != nil
      @notification_tester_object.object.should == @object
      @notification_tester_object.notification[:key].should == :value
    end

    it "should return nil if userInfo wasn't sent" do
      @notification.post_notification(@object)
      @notification_tester_object.notified?.should == true
      @notification_tester_object.notification.should != nil
      @notification_tester_object.object.should == @object
      @notification_tester_object.notification[:key].should == nil
    end
  end

  after do
    @notification.remove_observer(@notification_tester)
    @notification.remove_observer(@notification_tester_object, @object)
  end

end
