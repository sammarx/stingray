module Stingray
  class LoadBalancer
    def initalize
      @lb||=Stingray::Config.new
      puts @lb
    end
    def get_servers

    end
    
    def create_lb
    end

    def delete_lb
    end


  end
end
