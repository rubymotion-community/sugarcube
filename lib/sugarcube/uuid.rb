module SugarCube
  module UUID
    module_function

    def uuid
      new_id = CFUUIDCreate(nil)
      CFUUIDCreateString(nil, new_id)
    end
  end
end
