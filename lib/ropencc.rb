# -*- encoding: utf-8 -*-
require 'ffi'
require "ropencc/version"

module Ropencc
  module LibOpenCC
    extend FFI::Library
    ffi_lib 'opencc'
    attach_function :opencc_open, [:string], :pointer
    attach_function :opencc_close, [:pointer], :int
    attach_function :opencc_convert_utf8, [:pointer, :string, :int], :pointer
    attach_function :opencc_convert, [:pointer, :string, :int], :int
    attach_function :opencc_perror, [:string], :void
    attach_function :opencc_dict_load, [:pointer, :string, :int], :int
  end
  module LibC
    extend FFI::Library
    ffi_lib FFI::Library::LIBC
    attach_function :free, [:pointer], :void
  end # module LibC

  DICTS = {
    :simp_to_trad => ['simp_to_trad_characters.ocd','simp_to_trad_phrases.ocd','simp_to_trad_variant.ocd'],
    :trad_to_simp => ['trad_to_simp_characters.ocd','trad_to_simp_phrases.ocd','trad_to_simp_variant.ocd']
  }

  class << self
    def conv(dicttype, str)
      od = LibOpenCC.opencc_open nil
      DICTS[dicttype.to_sym].each { |dict| LibOpenCC.opencc_dict_load(od, dict, 1) }
      ptr = LibOpenCC.opencc_convert_utf8(od, str, str.bytesize)
      out_str = ptr.read_string
      LibC.free ptr
      LibOpenCC.opencc_close od
      out_str
    end
  end
end
