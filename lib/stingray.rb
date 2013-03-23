require 'rest_client'
require 'json'
require 'map'
require_relative "stingray/service_interface"
require_relative "stingray/config"
require_relative "stingray/pools"


module Stingray
  class << self
    def config options = {}
      @@config||=Stingray::Config.new(options)
    end

  end

end


