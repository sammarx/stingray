require 'minitest/spec'
require 'minitest/autorun'
require_relative "../lib/stingray"

describe "Stingray" do


    it "should return a configuration object" do
      Stingray.config.must_be_kind_of(Stingray::Config)
    end

    it "should pass arguments through #config" do
      Stingray.config({:url => "url", :user => "user", :password => "password"}).must_be_instance_of(Stingray::Config)
    end

    it "should return the same config when no options are added" do
      Stingray.config.must_equal(Stingray.config)
    end



end