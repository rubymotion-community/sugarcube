# Factory methods for UITableViewCell
class UITableViewCell

  class << self

    # returns a cell in the default style, with reuse identifier
    # `cell_identifier`.  Options are passed on to the
    # `sugarcube_cell_factory` method.
    def default(cell_identifier, options={})
      return sugarcube_cell_factory(cell_identifier, :default, options)
    end

    # returns a cell in the value1 style, with reuse identifier
    # `cell_identifier`.  Options are passed on to the
    # `sugarcube_cell_factory` method.
    def value1(cell_identifier, options={})
      return sugarcube_cell_factory(cell_identifier, :value1, options)
    end

    # returns a cell in the value2 style, with reuse identifier
    # `cell_identifier`.  Options are passed on to the
    # `sugarcube_cell_factory` method.
    def value2(cell_identifier, options={})
      return sugarcube_cell_factory(cell_identifier, :value2, options)
    end

    # returns a cell in the subtitle style, with reuse identifier
    # `cell_identifier`.  Options are passed on to the
    # `sugarcube_cell_factory` method.
    def subtitle(cell_identifier, options={})
      return sugarcube_cell_factory(cell_identifier, :subtitle, options)
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
    def sugarcube_cell_factory(cell_identifier, cell_style, options)
      cell_style = cell_style.uitablecellstyle if cell_style.respond_to?(:uitablecellstyle)
      cell = UITableViewCell.alloc.initWithStyle(cell_style, reuseIdentifier: cell_identifier)

      if options[:accessory]
        accessory = options[:accessory]
        accessory = accessory.uitablecellaccessorytype if accessory.respond_to?(:uitablecellaccessorytype)
        cell.accessoryType = accessory
      end

      if options[:selection]
        selection = options[:selection]
        selection = selection.uitablecellselectionstyle if selection.respond_to?(:uitablecellselectionstyle)
        cell.selectionStyle = selection
      end

      if options[:image]
        raise "cell type #{cell_style} does not support imageView" unless cell.imageView
        image = options[:image]
        cell.imageView.image = image && image.uiimage
      end

      if options[:text]
        cell.textLabel.text = options[:text]
      end

      if options[:detail]
        raise "cell type #{cell_style} does not support detailTextLabel" unless cell.detailTextLabel
        cell.detailTextLabel.text = options[:detail]
      end

      return cell
    end

  end

end
