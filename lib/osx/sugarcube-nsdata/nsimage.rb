class NSImage

  # @return [NSData] an NSData object in an image file format. compression is
  # optional, and only supported on the JPEG formats
  def nsdata(format=:png, compression=0.9)
    self.lockFocus
    bitmap_rep = NSBitmapImageRep.alloc.initWithFocusedViewRect(NSMakeRect(0, 0, self.size.width, self.size.height))
    self.unlockFocus

    case format
    when :png, :PNG
      return bitmap_rep.representationUsingType(NSPNGFileType, properties: nil)
    when :jpg, :jpeg, :JPG, :JPEG
      return bitmap_rep.representationUsingType(NSJPEGFileType, properties: { NSImageCompressionFactor => compression })
    when :jpg2000, :jpeg2000, :JPG2000, :JPEG2000
      return bitmap_rep.representationUsingType(NSJPEG2000FileType, properties: { NSImageCompressionFactor => compression })
    when :tif, :tiff, :TIF, :TIFF
      return bitmap_rep.representationUsingType(NSTIFFFileType, properties: nil)
    when :gif, :GIF
      return bitmap_rep.representationUsingType(NSGIFFileType, properties: nil)
    when :bmp, :BMP
      return bitmap_rep.representationUsingType(NSBMPFileType, properties: nil)
    end
  end

end
