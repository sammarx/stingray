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
        node_arr.map {|node| current_nodes << node unless current_nodes.include?(node)}
        set_nodes(current_nodes.uniq)
      end

      # delete an array of nodes from the pool
      def delete_nodes_from_pool(node_arr)
        current_nodes=nodes
        node_arr.map {|node| current_nodes.delete(node)if current_nodes.include?(node)}
        set_nodes(current_nodes.uniq)
      end

      # set nodes for a pool
      def set_nodes(node_arr)
        @pool_hash.properties.basic.nodes=node_arr
      end

      # Delete a pool. 
      def destroy
        return false if @name.nil?
        delete_rest "pools/#{@name}"
        true
      end

      # Save the current pool.  
      def save
        return false if @pool_hash.nil?
        put_rest "pools/#{@name}", @pool_hash.to_json, :content_type => "application/json"
        true
      end
    
  end
end
