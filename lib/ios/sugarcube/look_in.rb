module SugarCube
  module_function

  def look_in(where, here, here__deprecated={})
    return here[where] if here.has_key? where
    if here__deprecated[where]
      translated = here__deprecated[where]
      SugarCube.log("The symbol #{where.inspect} has been deprecated in favor of #{translated.inspect}")
      return here[translated]
    end
    raise SugarCubeNotFoundException.new(where.inspect)
  end

end

class SugarCubeNotFoundException < Exception
end
