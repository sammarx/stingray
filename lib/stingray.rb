require 'rest_client'
require 'json'
require_relative "stingray/lb"

module Stingray
  class Config
    attr_accessor :url, :user, :password

    def initialize(url,user,password)
      @url=url
      @user=user
      @password=password
    end

    def get_rest
       @rest||=RestClient::Resource.new(@url,:user => @user, :password => @password)
    end

    def get_endpoint(endpoint='')
      begin
        @r=get_rest[endpoint].get
      rescue => error
        error.response
      end
            #@rest_endpoints[@rest_endpoints.keys.first].map{|k| @endpoints[k.values.first.to_sym]=@endpoints[k.values.last.to_sym]}
      @actions={}
      @response=JSON.parse(@r)
      if @response.include?('children')

        @response[@response.keys.first].map{|k|  @actions[k.values.first]=k.values.last} unless error
        @actions
      elsif @response.include?('properties')
        
        @response[@response.keys.first]
      else
        @response
      end
      
    end

  end

end

