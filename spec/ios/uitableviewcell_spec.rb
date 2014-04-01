describe UITableViewCell do

  it 'should create a default cell' do
    cell = UITableViewCell.default('cell_identifier')
    cell.should.be.kind_of(UITableViewCell)
    cell.reuseIdentifier.should == 'cell_identifier'
    # there's no way to test for the style :-/
  end

  it 'should create a value1 cell' do
    cell = UITableViewCell.value1('cell_identifier')
    cell.should.be.kind_of(UITableViewCell)
    cell.reuseIdentifier.should == 'cell_identifier'
    # there's no way to test for the style :-/
  end

  it 'should create a value2 cell' do
    cell = UITableViewCell.value2('cell_identifier')
    cell.should.be.kind_of(UITableViewCell)
    cell.reuseIdentifier.should == 'cell_identifier'
    # there's no way to test for the style :-/
  end

  it 'should create a subtitle cell' do
    cell = UITableViewCell.subtitle('cell_identifier')
    cell.should.be.kind_of(UITableViewCell)
    cell.reuseIdentifier.should == 'cell_identifier'
    # there's no way to test for the style :-/
  end

  it 'should accept options (image)' do
    cell = UITableViewCell.default('cell_identifier',
      accessory: :disclosure,
      selection: :blue,
      text: 'text',
      image: 'little_square',
      )
    cell.accessoryType.should == UITableViewCellAccessoryDisclosureIndicator
    cell.selectionStyle.should == UITableViewCellSelectionStyleBlue
    cell.textLabel.text.should == 'text'
    cell.imageView.image.should == 'little_square'.uiimage
  end

  it 'should accept options (detail)' do
    cell = UITableViewCell.value2('cell_identifier',
      accessory: :disclosure,
      selection: :blue,
      text: 'text',
      detail: 'detail text',
      )
    cell.accessoryType.should == UITableViewCellAccessoryDisclosureIndicator
    cell.selectionStyle.should == UITableViewCellSelectionStyleBlue
    cell.textLabel.text.should == 'text'
    cell.detailTextLabel.text.should == 'detail text'
  end

end

# accessory
# selection
# text
# image
# detail