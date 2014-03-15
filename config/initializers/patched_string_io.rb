class PatchedStringIO < StringIO
  attr_accessor :original_filename
end