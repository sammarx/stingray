module Stingray
  class Vserver
    include Stingray::ServiceInterface
    attr_accessor :name, :vserver, :vservers, :vserver_hash, :pool
    
    # Get a list of all vservers
    def vservers
      @vservers=get_endpoint('vservers').keys
    end

    # get one specific vserver
    def vserver(name)
      begin
        @name=name
        @vserver_hash=get_endpoint("vservers/#{@name}")
      rescue Stingray::NotFoundError 
        nil
      end
    end

    # default pool for vserver
    def pool
      @pool=@vserver_hash.properties.basic.pool
    end

    # set pool for vserver
    def pool=(pool)
      @vserver_hash.properties.basic.pool=pool
    end

    # create a new vserver
    def create(name)
      @name=name
      @vserver_hash=Map.new.set(:properties, :basic, :pool)
    end

    # Save the current vserver.  
    def save
      return if @vserver_hash.nil?
      put_rest "vservers/#{@name}", @vserver_hash.to_json, :content_type => "application/json"
    end

    # destroy the current vserver.
    def destroy
      return if @name.nil?
      delete_rest "vservers/#{@name}"
    end


  end
end