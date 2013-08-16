module Stingray
  class Monitor
    include Stingray::ServiceInterface
    attr_accessor :name, :monitor, :monitors, :monitor_hash
    
    # Get a list of all monitors
    def monitors
      @monitors=get_endpoint('monitors').keys
    end

    # get one specific monitor
    def monitor(name)
      begin
        @name=name
        @monitor_hash=get_endpoint("monitors/#{@name}") 
      rescue Stingray::NotFoundError 
        nil
      end
    end

    # create a new monitor
    def create(name)
      @name=name
      @monitor_hash=Map.new.set(:properties, :basic, :http, :path)
    end

    # Save the current monitor.  
    def save
      return if @monitor_hash.nil?
      put_rest "monitors/#{@name}", @monitor_hash, :content_type => "application/json"
    end

    # destroy the current monitor.
    def destroy
      return if @name.nil?
      delete_rest "monitors/#{@name}"
    end


  end
end