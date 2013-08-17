require 'rest_client'
require 'json'
require 'map'
require_relative "stingray/error"
require_relative "stingray/service_interface"
require_relative "stingray/config"
require_relative "stingray/pools"
require_relative "stingray/extra"
require_relative "stingray/vservers"
require_relative "stingray/monitors"
require_relative "stingray/rules"


module Stingray
  class << self
    def config(options = {})
      @@config||=Stingray::Config.new(options)
    end

  end

end


