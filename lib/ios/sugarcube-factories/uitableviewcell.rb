# Factory methods for UITableViewCell
class UITableViewCell

  class << self

    # returns a cell in the default style, with reuse identifier
    # `reuse_identifier`.  Supported options are :accessory, :text, :detail,
    # :image, and :selection_style.
    # Valid values for `:accessory`:
    #      :none, :disclosure, :disclosureindicator, :detail,
    #      :detaildisclosurebutton, :checkmark
    #      or any UITableViewCellAccessory constant
    # Valid values for `:selection_style`:
    #      :none, :blue, :gray
    #      or any UITableViewCellSelectionStyle constant
    def default(reuse_identifier, options={})
      return sugarcube_cell_factory(reuse_identifier, :default, options)
    end

    # returns a cell in the value1 style, with reuse identifier
    # `reuse_identifier`.  Supported options are :accessory, :text, :detail,
    # :image, and :selection_style.
    # Valid values for `:accessory`:
    #      :none, :disclosure, :disclosureindicator, :detail,
    #      :detaildisclosurebutton, :checkmark
    #      or any UITableViewCellAccessory constant
    # Valid values for `:selection_style`:
    #      :none, :blue, :gray
    #      or any UITableViewCellSelectionStyle constant
    def value1(reuse_identifier, options={})
      return sugarcube_cell_factory(reuse_identifier, :value1, options)
    end

    # returns a cell in the value2 style, with reuse identifier
    # `reuse_identifier`.  Supported options are :accessory, :text, :detail,
    # :image, and :selection_style.
    # Valid values for `:accessory`:
    #      :none, :disclosure, :disclosureindicator, :detail,
    #      :detaildisclosurebutton, :checkmark
    #      or any UITableViewCellAccessory constant
    # Valid values for `:selection_style`:
    #      :none, :blue, :gray
    #      or any UITableViewCellSelectionStyle constant
    def value2(reuse_identifier, options={})
      return sugarcube_cell_factory(reuse_identifier, :value2, options)
    end

    # returns a cell in the subtitle style, with reuse identifier
    # `reuse_identifier`.  Supported options are :accessory, :text, :detail,
    # :image, and :selection_style.
    # Valid values for `:accessory`:
    #      :none, :disclosure, :disclosureindicator, :detail,
    #      :detaildisclosurebutton, :checkmark
    #      or any UITableViewCellAccessory constant
    # Valid values for `:selection_style`:
    #      :none, :blue, :gray
    #      or any UITableViewCellSelectionStyle constant
    def subtitle(reuse_identifier, options={})
      return sugarcube_cell_factory(reuse_identifier, :subtitle, options)
    end

private

    # Available options:
    #   accessory - accessoryType.  Valid values:
    #      :none, :disclosure, :disclosureindicator, :detail,
    #      :detaildisclosurebutton, :checkmark
    #      or any UITableViewCellAccessory constant
    #   text - textLabel.text content
    #   detail - detailTextLabel.text content
    #   selection - selectionStyle
    def sugarcube_cell_factory(reuse_identifier, cell_style, options)
      cell_style_name = cell_style
      cell_style = cell_style.uitablecellstyle if cell_style.respond_to?(:uitablecellstyle)
      cell = UITableViewCell.alloc.initWithStyle(cell_style, reuseIdentifier: reuse_identifier)

      if options[:accessory]
        accessory = options[:accessory]
        accessory = accessory.uitablecellaccessorytype if accessory.respond_to?(:uitablecellaccessorytype)
        cell.accessoryType = accessory
      end

      selection_style = options[:selection] || options[:selection_style]
      if selection_style
        selection_style = selection_style.uitablecellselectionstyle if selection_style.respond_to?(:uitablecellselectionstyle)
        cell.selectionStyle = selection_style
      end

      if options[:image]
        raise "cell type #{cell_style_name} does not support imageView" unless cell.imageView
        image = options[:image]
        cell.imageView.image = image && image.uiimage
      end

      if options[:text]
        cell.textLabel.text = options[:text]
      end

      if options[:detail]
        raise "cell type #{cell_style_name} does not support detailTextLabel" unless cell.detailTextLabel
        cell.detailTextLabel.text = options[:detail]
      end

      return cell
    end

  end

end
