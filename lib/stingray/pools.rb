module Stingray
   
 
    class Pool 
      
      include Stingray::ServiceInterface

      attr_accessor :name, :pool_hash, :pools, :pool, :nodes, :monitors, :note


      # List all available pools
      def pools
        @pools=get_endpoint("pools").keys
      end

      # Get a named pool
      def pool(name)
        begin
          @name=name
          @pool_hash=get_endpoint("pools/#{@name}") 
        rescue Stingray::NotFoundError 
          nil
        end
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

      # set nodes
      def nodes=(node_arr)
        @pool_hash.properties.basic.nodes=node_arr
      end

      # list monitors for a pool
      def monitors
        @monitors=@pool_hash.properties.basic.monitors || []
      end

      # monitors
      def monitors=(monitor_arr)
        @monitors=@pool_hash.properties.basic.monitors=monitor_arr
      end

      # notes
      def note
        @note=@pool_hash.properties.basic.note
      end

      def note=(note)
        @pool_hash.properties.basic.note=note
      end

      # add an array of nodes to the pool
      def add_nodes_to_pool(node_arr)
        current_nodes=nodes
        node_arr.map {|node| current_nodes << node unless current_nodes.include?(node)}
        nodes=current_nodes.uniq
      end

      # delete an array of nodes from the pool
      def delete_nodes_from_pool(node_arr)
        current_nodes=nodes
        node_arr.map {|node| current_nodes.delete(node)if current_nodes.include?(node)}
        nodes=current_nodes.uniq
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
