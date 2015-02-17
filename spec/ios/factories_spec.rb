describe 'SugarCube Factories' do

  describe NSError do
    [
      'with message',             -> { NSError.error('message') },
      'with message and options', -> { NSError.error('message', domain: 'Error', code: 1, userInfo: {}) },
    ].each_slice(2) do |description, factory|
      it "should work #{description}" do
        error = factory.call
        error.should.be.kind_of NSError
      end
    end
  end

  describe UIActivityIndicatorView do
    [
      'with #large', -> { UIActivityIndicatorView.large },
      'with #white', -> { UIActivityIndicatorView.white },
      'with #gray',  -> { UIActivityIndicatorView.gray },
    ].each_slice(2) do |description, factory|
      it "should work #{description}" do
        error = factory.call
        error.should.be.kind_of UIActivityIndicatorView
      end
    end
  end

  describe UIBarButtonItem do
    [
      'with #done',           -> { UIBarButtonItem.done },
      'with #cancel',         -> { UIBarButtonItem.cancel },
      'with #edit',           -> { UIBarButtonItem.edit },
      'with #save',           -> { UIBarButtonItem.save },
      'with #add',            -> { UIBarButtonItem.add },
      'with #flexible_space', -> { UIBarButtonItem.flexible_space },
      'with #fixed_space',    -> { UIBarButtonItem.fixed_space },
      'with #compose',        -> { UIBarButtonItem.compose },
      'with #reply',          -> { UIBarButtonItem.reply },
      'with #action',         -> { UIBarButtonItem.action },
      'with #organize',       -> { UIBarButtonItem.organize },
      'with #bookmarks',      -> { UIBarButtonItem.bookmarks },
      'with #search',         -> { UIBarButtonItem.search },
      'with #refresh',        -> { UIBarButtonItem.refresh },
      'with #stop',           -> { UIBarButtonItem.stop },
      'with #camera',         -> { UIBarButtonItem.camera },
      'with #trash',          -> { UIBarButtonItem.trash },
      'with #play',           -> { UIBarButtonItem.play },
      'with #pause',          -> { UIBarButtonItem.pause },
      'with #rewind',         -> { UIBarButtonItem.rewind },
      'with #fast_forward',   -> { UIBarButtonItem.fast_forward },
      'with #undo',           -> { UIBarButtonItem.undo },
      'with #redo',           -> { UIBarButtonItem.redo },
      'with #page_curl',      -> { UIBarButtonItem.page_curl },
      'with #titled',         -> { UIBarButtonItem.titled('test') },
      'with #imaged',         -> { UIBarButtonItem.imaged(nil) },
    ].each_slice(2) do |description, factory|
      it "should work #{description}" do
        error = factory.call
        error.should.be.kind_of UIBarButtonItem
      end
    end
  end

  if defined?(UIBlurEffectStyleDark)
    describe UIBlurEffect do
      [
        'with #dark', -> { UIBlurEffect.dark },
        'with #light', -> { UIBlurEffect.light },
        'with #extra_light',  -> { UIBlurEffect.extra_light },
      ].each_slice(2) do |description, factory|
        it "should work #{description}" do
          error = factory.call
          error.should.be.kind_of UIBlurEffect
        end
      end
    end
  end

  describe UIButton do
    [
      'with #custom',            -> { UIButton.custom },
      'with #rounded',           -> { UIButton.rounded },
      'with #rounded_rect',      -> { UIButton.rounded_rect },
      'with #detail',            -> { UIButton.detail },
      'with #detail_disclosure', -> { UIButton.detail_disclosure },
      'with #info',              -> { UIButton.info },
      'with #info_light',        -> { UIButton.info_light },
      'with #info_dark',         -> { UIButton.info_dark },
      'with #contact',           -> { UIButton.contact },
      'with #contact_add',       -> { UIButton.contact_add },
      'with #system',            -> { UIButton.system },
    ].each_slice(2) do |description, factory|
      it "should work #{description}" do
        error = factory.call
        error.should.be.kind_of UIButton
      end
    end
  end

  describe UISegmentedControl do
    [
      'with #plain(items)', -> { UISegmentedControl.plain([]) },
      'with #bordered(items)', -> { UISegmentedControl.bordered([]) },
      'with #bar(items)', -> { UISegmentedControl.bar([]) },
      'with #bezeled(items)', -> { UISegmentedControl.bezeled([]) },
    ].each_slice(2) do |description, factory|
      it "should work #{description}" do
        error = factory.call
        error.should.be.kind_of UISegmentedControl
      end
    end

  end

  describe UITabBarItem do
    [
      'with #titled',      -> { UITabBarItem.titled('title') },
      'with #titled with options', -> { UITabBarItem.titled('title', tag: 1, badge: 2, image: 'little_square', selected_image: 'little_square') },
      'with #system',      -> { UITabBarItem.system(UITabBarSystemItemMore) },
      'with #system with options', -> { UITabBarItem.system(UITabBarSystemItemMore, tag: 1, badge: 2, image: 'little_square', selected_image: 'little_square') },
      'with #more',        -> { UITabBarItem.more },
      'with #favorites',   -> { UITabBarItem.favorites },
      'with #featured',    -> { UITabBarItem.featured },
      'with #top_rated',   -> { UITabBarItem.top_rated },
      'with #recents',     -> { UITabBarItem.recents },
      'with #contacts',    -> { UITabBarItem.contacts },
      'with #history',     -> { UITabBarItem.history },
      'with #bookmarks',   -> { UITabBarItem.bookmarks },
      'with #search',      -> { UITabBarItem.search },
      'with #downloads',   -> { UITabBarItem.downloads },
      'with #most_recent', -> { UITabBarItem.most_recent },
      'with #most_viewed', -> { UITabBarItem.most_viewed },
    ].each_slice(2) do |description, factory|
      it "should work #{description}" do
        error = factory.call
        error.should.be.kind_of UITabBarItem
      end
    end

  end

  describe UITableView do
    [
      'with #plain', -> { UITableView.plain },
      'with #plain with frame', -> { UITableView.plain([[0, 0], [320, 480]]) },
      'with #grouped', -> { UITableView.grouped },
      'with #grouped with frame', -> { UITableView.grouped([[0, 0], [320, 480]]) },
    ].each_slice(2) do |description, factory|
      it "should work #{description}" do
        error = factory.call
        error.should.be.kind_of UITableView
      end
    end
  end

  describe UITableViewCell do
    [
      'with #default', -> { UITableViewCell.default('identifier') },
      'with #default with options', -> { UITableViewCell.default('identifier', accessory: :disclosure, selection_style: :none, text: 'text', detailText: 'detail') },
      'with #default with old options (:selection)', -> { UITableViewCell.default('identifier', accessory: :disclosure, selection: :none, text: 'text', detailText: 'detail') },
      'with #value1', -> { UITableViewCell.value1('identifier') },
      'with #value1 with options', -> { UITableViewCell.value1('identifier', accessory: :disclosure, selection_style: :none, text: 'text', detailText: 'detail') },
      'with #value1 with old options (:selection)', -> { UITableViewCell.value1('identifier', accessory: :disclosure, selection: :none, text: 'text', detailText: 'detail') },
      'with #value2', -> { UITableViewCell.value2('identifier') },
      'with #value2 with options', -> { UITableViewCell.value2('identifier', accessory: :disclosure, selection_style: :none, text: 'text', detailText: 'detail') },
      'with #value2 with old options (:selection)', -> { UITableViewCell.value2('identifier', accessory: :disclosure, selection: :none, text: 'text', detailText: 'detail') },
      'with #subtitle', -> { UITableViewCell.subtitle('identifier') },
      'with #subtitle with options', -> { UITableViewCell.subtitle('identifier', accessory: :disclosure, selection_style: :none, text: 'text', detailText: 'detail') },
      'with #subtitle with old options (:selection)', -> { UITableViewCell.subtitle('identifier', accessory: :disclosure, selection: :none, text: 'text', detailText: 'detail') },
    ].each_slice(2) do |description, factory|
      it "should work #{description}" do
        error = factory.call
        error.should.be.kind_of UITableViewCell
      end
    end
  end

  describe UILabel do

    describe 'new method' do
      it 'should support UILabel.label' do
        label = UILabel.label
        label.should.be.kind_of(UILabel)
      end
      it 'should support UILabel.label(text)' do
        label = UILabel.label('text')
        label.should.be.kind_of(UILabel)
        label.text.should == 'text'
      end
      it 'should support UILabel.label(text, font)' do
        label = UILabel.label('text', UIFont.fontWithName('Helvetica', size: 10))
        label.should.be.kind_of(UILabel)
        label.text.should == 'text'
        label.font.familyName.should == 'Helvetica'
        label.font.pointSize.should == 10
      end
      it 'should support UILabel.label(text, font_name)' do
        label = UILabel.label('text', 'Helvetica')
        label.should.be.kind_of(UILabel)
        label.text.should == 'text'
        label.font.familyName.should == 'Helvetica'
      end
      it 'should support UILabel.label(text, font_name, size)' do
        label = UILabel.label('text', 'Helvetica', 10)
        label.should.be.kind_of(UILabel)
        label.text.should == 'text'
        label.font.familyName.should == 'Helvetica'
        label.font.pointSize.should == 10
      end
    end
  end

end
