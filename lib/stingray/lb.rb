module Stingray
  
  class LB
   # attr_accessor :name, :servers, :rules, :extras
    
    def initialize(name)
      
      @name=name
      @config=config
    end

    def config
      Stingray::Config.new
    end

    def get_servers
      puts @@rest
      @lb.get_endpoint('extra')

    end
    
    def create_lb
    end

    def delete_lb
    end


  end
end
