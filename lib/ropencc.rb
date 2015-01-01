# -*- encoding: utf-8 -*-

require 'ffi'

class Ropencc
    module LibOpenCC
        extend FFI::Library
        ffi_lib 'opencc'
        attach_function :opencc_open, [:string], :pointer
        attach_function :opencc_close, [:pointer], :int
        attach_function :opencc_convert_utf8_to_buffer, [:pointer, :string, :int, :pointer], :int
        attach_function :opencc_convert_utf8, [:pointer, :string, :int], :pointer
        attach_function :opencc_convert_utf8_free, [:pointer], :void
        attach_function :opencc_error, [], :string
    end

    attr_accessor :descriptor

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

    def self.conv(config, str)
        od = LibOpenCC.opencc_open config
        ptr = LibOpenCC.opencc_convert_utf8(od, str, str.bytesize)
        out_str = ptr.read_string
        LibOpenCC.opencc_convert_utf8_free ptr
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
        LibOpenCC.opencc_convert_utf8_free ptr
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
