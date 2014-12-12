class UIPickerView
  def [] index
    self.selectedRowInComponent(index)
  end

  def []= index, value
    self.selectRow(value, inComponent:index, animated:true)
  end
end
