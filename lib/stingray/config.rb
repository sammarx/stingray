module Stingray
  class Config
    
    # Give us a standard interface for all of the sub modules.
    def initialize(args={})      
      args.each do |key,val| 
        self.class.__send__(:attr_accessor,"#{key}")
        instance_variable_set("@#{key}",val)
      end
      
    end
  end

end