module Stingray
   
 
    class Pool < Stingray::Config
      attr_accessor :name, :pool_hash
      def pool(name)
        @pool_hash=Map.new(get_endpoint("pools/#{name}")) rescue Map.new.set(:properties, :basic, :nodes,[])
        @name=name
        #@pool=Map.new(:properties,:basic,:nodes,[])

      end      
      def servers
        @pool_hash.properties.basic.nodes
      end

      def add_servers_to_pool(servers=[])
        current_servers=@pool_hash.properties.basic.nodes
        current_servers<<servers
        @pool_hash.properties.basic.nodes=current_servers
      end

      def save
        puts @pool_hash.to_json

        get_rest["pools/#{@name}"].put @pool_hash.to_json, :content_type => "application/json"
        #get_rest["pools/#{@name}"].put(@pool_hash.to_json, :content_type => "application/json")  if @pool_hash
      end
    
  end
end
