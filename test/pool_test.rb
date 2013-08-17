require 'helper'

module Stingray
  class PoolTest < Test::Unit::TestCase

    context 'has config and pool' do 
      setup do 
        @config = Stingray.config({:url => "http://localhost/", :user => "user", :password => "password"})
        @client = Pool.new
      end

      context 'a pool returns 404' do 
        setup do 
          stub_request(:get, "http://user:password@localhost/pools/blah").to_return(status: 404, body: 'bawdy')
          @pool = @client.pool('blah')
        end
        
        should 'return nil' do
          assert_nil @pool
        end
      end

      context 'a pool returns 200' do 
        setup do 
          stub_request(:get, "http://user:password@localhost/pools/blah").to_return(status: 200, body: "{\"prop\":\"meh\"}")
          @pool = @client.pool('blah')
        end
        
        should 'return pool hash' do
          assert 'meh', @pool[:prop]
        end
      end

    end

  end
end