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

    %w(get delete).each do |verb|
      define_method("#{verb}_rest") do |path|
        begin
          rest[URI.escape(path)].send(verb)
        rescue RestClient::Exception => e
          raise_error(e)
        end
      end
    end

    %w(post put).each do |verb|
      define_method("#{verb}_rest") do |path, content, opts|
        begin
          rest[URI.escape(path)].send(verb, content, opts)
        rescue RestClient::Exception => e
          raise_error(e)
        end
      end
    end

    # Default REST object
    def rest
      @rest||=RestClient::Resource.new(URI.escape(@url),:user => @user, :password => @password)
    end

    # Parse out the endpoint
    def get_endpoint(endpoint='')
      r=self.get_rest(endpoint)
      actions={}
      response=Map.new(JSON.parse(r))
      if response.respond_to?(:children)
        response.children.map{|k| actions[k.values.first]=k.values.last} unless error
        actions
      else 
        response
      end
    end

    private 

    def raise_error(e)
      if e.is_a? RestClient::ResourceNotFound
        raise NotFoundError.new(e)
      else
        raise Error.new(e)
      end
    end

  end
end
