# -*- encoding: utf-8 -*-

require 'ffi'

class Ropencc
    VERSION = '0.0.5'

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

    attr_accessor :descriptor

    CONFIGS = ['zhs2zhtw_p.ini', 'zhs2zhtw_v.ini', 'zhs2zhtw_vp.ini', 'zht2zhtw_p.ini', 
               'zht2zhtw_v.ini', 'zht2zhtw_vp.ini', 'zhtw2zhs.ini', 'zhtw2zht.ini', 
               'zhtw2zhcn_s.ini', 'zhtw2zhcn_t.ini', 'zhs2zht.ini', 'zht2zhs.ini']

    DICTS = {
        :simp_to_trad => 'zhs2zhtw_vp.ini',
        :trad_to_simp => 'zhtw2zhcn_s.ini'
    }

    def initialize(config_file)
        @descriptor = LibOpenCC.opencc_open config_file
        @is_open = true
    end

    private :initialize

    def self.open(*args)
        cc = new(*args)

        return cc unless block_given?

        begin
            yield cc
        ensure
            begin
                cc.close unless cc.closed?
            rescue StandardError
                # nothing, just swallow them
            end
        end
    end

    def self.conv(dicttype, str)
        raise 'unknown simple conversion type' if DICTS.has_key?(dicttype)
        od = LibOpenCC.opencc_open DICTS[dicttype.to_sym]
        ptr = LibOpenCC.opencc_convert_utf8(od, str, str.bytesize)
        out_str = ptr.read_string
        LibC.free ptr
        LibOpenCC.opencc_close od
        out_str.force_encoding("UTF-8") if out_str.respond_to?(:force_encoding)
        out_str

    end

    def convert(str)
        if @is_open == false
            raise IOError, 'not opened for conversion'
        end

        ptr = LibOpenCC.opencc_convert_utf8(@descriptor, str, str.bytesize)
        out_str = ptr.read_string
        LibC.free ptr
        out_str.force_encoding("UTF-8") if out_str.respond_to?(:force_encoding)
        out_str
    end


    def closed?
        @is_open == false
    end

    def close
        LibOpenCC.opencc_close @descriptor
        @descriptor = nil
        @is_open = false

        return nil
    end
end
