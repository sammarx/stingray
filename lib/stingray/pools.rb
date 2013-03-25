module Stingray
   
 
    class Pool 
      
      include Stingray::ServiceInterface

      attr_accessor :name, :pool_hash, :pools, :nodes
      
      # List all available pools
      def list_pools
        @pools=get_endpoint("pools").keys
      end

      # Get a named pool
      def pool(name)
        @name=name
        @pool_hash=get_endpoint("pools/#{@name}") rescue nil
      end  

      # Create a new pool
      def create(name)
        @name=name
        @pool_hash=Map.new.set(:properties, :basic, :nodes,[])
      end

      # list the nodes of a pool
      def nodes
        @nodes=@pool_hash.properties.basic.nodes || []
      end

      # add an array of nodes to the pool
      def add_nodes_to_pool(node_arr)
        current_nodes=nodes
        serv_arr.map {|node| current_nodes << node unless current_nodes.include?(node)}
        @pool_hash.properties.basic.nodes=current_nodes
      end

      # delete an array of nodes from the pool
      def delete_nodes_from_pool(serv_arr)
        current_nodes=nodes
        serv_arr.map {|node| current_nodes.delete(node)if current_nodes.include?(node)}
        @pool_hash.properties.basic.nodes=current_nodes
      end

      # Delete a pool. 
      def destroy
        return if @name.nil?
        get_rest["pools/#{@name}"].delete 
      end

      # Save the current pool.  
      def save
        return if @pool_hash.nil?
        get_rest["pools/#{@name}"].put @pool_hash.to_json, :content_type => "application/json"
      end
    
  end
end
