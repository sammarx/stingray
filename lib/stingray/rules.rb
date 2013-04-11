module Stingray
  class Rule
    
    include Stingray::ServiceInterface
    attr_accessor :name, :rules, :content
    
    # Get a list of all rules
    def list_rules
      @rules=get_endpoint('rule').keys
    end

    # get one specific rule
    def rule(name)
      @name=name
      @content=get_rest "rules/#{@name}" rescue nil
    end

    # create a new rule
    def create(name,content='')
      @name=name
      @content=content
    end

    # Save the current rule.  
    def save
      return if @content.nil?
      put_rest "rules/#{@name}", @content, :content_type => "application/octet-stream"
    end

    # destroy the current rule.
    def destroy
      return if @name.nil?
      delete_rest "rules/#{@name}"
    end


  end
end