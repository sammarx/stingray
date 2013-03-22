require 'minitest/spec'
require 'minitest/autorun'

describe Stingray::Config do
  it "must be created with arguments" do
    Stingray::Config.new.must_be_instance_of Array
  end

  it "can be created with a specific size" do
    Array.new(10).size.must_equal 10
  end
end