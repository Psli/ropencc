# -*- encoding: utf-8 -*-

#$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '../lib')

require 'test/unit'
require '../lib/ropencc'

class RopenccTest < Test::Unit::TestCase
    def test_ropencc_open
        cc = Ropencc.open 'zhtw2zhcn_s.ini'
        assert_not_nil cc, 'Ropencc.open should return a handle'
    end

    def test_ropencc_convert
        Ropencc.open 'zhtw2zhcn_s.ini' do |cc|
            rs = cc.convert '新年快樂'

            assert_equal '新年快乐', rs
        end
    end

    def test_ropencc_simple_conv
        rs = Ropencc.conv 'trad_to_simp', '新年快樂'
        assert_equal '新年快乐', rs
    end
end
