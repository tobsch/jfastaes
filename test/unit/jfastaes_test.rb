# coding: utf-8

require 'test_helper'
require 'benchmark'

class JFastAESTest < Test::Unit::TestCase
  context 'The Fast AES API' do
    setup do
      @aes = JFastAES.new('barbarbarbarbard')
    end
    
    should 'be able to encrypt a text and decrypt it back again' do
      assert_equal 'bar', @aes.decrypt(@aes.encrypt('bar'))
    end
    
    should 'be able to encrypt and decrypt a text with base64 in between' do
      assert_equal 'bar', @aes.decrypt64(@aes.encrypt64('bar'))
    end
    
    should 'return valid base64 encoded strings' do
      assert_equal 'qsIvKed32GrFeMarQ+NONQ==', @aes.encrypt64('bar')
    end    
    
    should 'be fast' do
      puts Benchmark.measure {
        1_000_000.times {
          @aes.decrypt(@aes.encrypt('bar'))
        }
      }
    end
  end
end