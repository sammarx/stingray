module Stingray
  class Config
    attr_accessor :url, :user, :password

    def initialize(args={})
      puts args
      
      @url=args[:url]
      @user=args[:user]
      @password=args[:password]
      
    
    end

    def get_rest
       @rest||=RestClient::Resource.new(@url,:user => @user, :password => @password)
    end

    def get_endpoint(endpoint='')
      begin
        @r=self.get_rest[endpoint].get
      rescue => error
        error.response
      end
      
            #@rest_endpoints[@rest_endpoints.keys.first].map{|k| @endpoints[k.values.first.to_sym]=@endpoints[k.values.last.to_sym]}
      @actions={}
      @response=JSON.parse(@r)
      if @response.include?('children')

        @response[@response.keys.first].map{|k|  @actions[k.values.first]=k.values.last} unless error
        @actions
      else 
        @response
        
        
      end
      
    end

  end

end