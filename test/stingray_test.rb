require 'helper'


module Stingray
  class TestStingray < Test::Unit::TestCase

    should 'return a config object' do 
      assert Stingray.config.is_a?(Stingray::Config)
    end

    should 'pass arguments through #config' do 
      assert Stingray.config({:url => "urltest", :user => "user", :password => "password"}).is_a?(Stingray::Config)
      assert_equal 'urltest', Stingray.config.url
      assert_equal 'user', Stingray.config.user
      assert_equal 'password', Stingray.config.password
    end

    should 'return same config when no options are added' do 
      assert_equal Stingray.config, Stingray.config
    end

  end
end
