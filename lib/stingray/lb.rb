module Stingray
  
  class LB
   # attr_accessor :name, :servers, :rules, :extras
    def initialize(name,args={})
      
      @name=name
      puts args.class
      @url=args[:url]
      @user=args[:user]
      @password=args[:password]
    end

   
    def config

      @config||=Stingray::Config.new(@url,@user,@password)
      
    end

    def get_vservers
      @lb=config
      @lb.get_endpoint('vservers')
    end

    def get_pools
      @lb=config
      @lb.get_endpoint('pools')

    end
    
    def create_lb
    end

    def delete_lb
    end


  end
end
