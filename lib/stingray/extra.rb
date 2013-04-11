module Stingray
  class Extra
    include Stingray::ServiceInterface
    attr_accessor :name, :files, :content
    
    # Get a list of all files
    def list_files
      @files=get_endpoint('extra').keys
    end

    # get one specific file
    def file(name)
      @name=name
      @content=get_rest("extra/#{@name}") rescue nil
    end

    # create a new file
    def create(name,content='')
      @name=name
      @content=content
    end

    # Save the current file.  
    def save
      return if @content.nil?
      put_rest "extra/#{@name}", @content, :content_type => "application/octet-stream"
    end

    # destroy the current file.
    def destroy
      return if @name.nil?
      delete_rest("extra/#{@name}")
    end


  end
end
