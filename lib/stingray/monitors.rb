module Stingray
  class Monitor
    include Stingray::ServiceInterface
    attr_accessor :name, :monitor, :monitor_hash
    
    # Get a list of all monitors
    def list_monitors
      @files=get_endpoint('monitors').keys
    end

    # get one specific monitor
    def monitor(name)
      @name=name
      @monitor_hash=get_endpoint("monitors/#{@name}") rescue nil
    end

    # create a new monitor
    def create(name)
      @name=name
      @monitor_hash=Map.new.set(:properties, :basic, :http, :path)
    end

    # Save the current monitor.  
    def save
      return if @monitor_hash.nil?
      get_rest["monitors/#{@name}"].put @monitor_hash, :content_type => "application/json"
    end

    # destroy the current monitor.
    def destroy
      return if @name.nil?
      get_rest["monitors/#{@name}"].delete 
    end


  end
end