module Stingray
  class Vserver
    include Stingray::ServiceInterface
    attr_accessor :name, :vserver, :vserver_hash
    
    # Get a list of all vservers
    def list_vservers
      @files=get_endpoint('vservers').keys
    end

    # get one specific vserver
    def vserver(name)
      @name=name
      @vserver_hash=get_endpoint("vservers/#{@name}") rescue nil
    end

    # create a new vserver
    def create(name)
      @name=name
      @vserver_hash=Map.new.set(:properties, :basic, :pool)
    end

    # Save the current vserver.  
    def save
      return if @vserver_hash.nil?
      get_rest["vservers/#{@name}"].put @vserver_hash, :content_type => "application/json"
    end

    # destroy the current vserver.
    def destroy
      return if @name.nil?
      get_rest["vservers/#{@name}"].delete 
    end


  end
end