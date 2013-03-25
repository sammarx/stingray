module Stingray    
  module ServiceInterface
    
    def initialize(args={})
      # Iterate over the existing config, if one exists, and set instance variables for the current object
      config=Stingray.config
      config.instance_variables.each do |var| 
        instance_variable_set("#{var}",config.instance_variable_get("#{var}"))
      end
      # Allow override of individual variables
      args.each do |key,val| 
        self.class.__send__(:attr_accessor,"#{key}")
        instance_variable_set("@#{key}",val)
      end

    end
    # Default REST object
    def get_rest
       @rest||=RestClient::Resource.new(@url,:user => @user, :password => @password)
    end

    # Parse out the endpoint
    def get_endpoint(endpoint='')
      begin
        @r=self.get_rest[URI.escape(endpoint)].get
      rescue => error
        error.response
      end      
      @actions={}
      @response=Map.new(JSON.parse(@r))
      if @response.respond_to?(:children)
        @response.children.map{|k|  @actions[k.values.first]=k.values.last} unless error
        @actions
      else 
        @response
        
        
      end
    end

  end
end
