require 'helper'

module Stingray

  class Client
    include ServiceInterface
  end

  class ServiceInterfaceTest < Test::Unit::TestCase

    context 'has config and client' do 
      setup do 
        @config = Stingray.config({:url => "http://localhost/", :user => "user", :password => "password"})
        @client = Client.new
      end

      context 'get_rest with success' do 
        setup do 
          stub_request(:get, "http://user:password@localhost/path").to_return(status: 200, body: 'bawdy')
          @response = @client.get_rest('path')
        end

        should 'return response as string' do 
          assert_equal 'bawdy', @response
          assert_equal 200, @response.code
        end
      end


      context 'get_rest with 404 response' do
        setup do 
          stub_request(:get, "http://user:password@localhost/pathtown").to_return(status: 404, body: 'errortown')
        end

        should 'throw Stingray::NotFoundError and retain rest exception' do 
          error = assert_raise(Stingray::NotFoundError){ @client.get_rest('pathtown') }
          assert error.rest_exception.is_a?(RestClient::ResourceNotFound)
          assert_equal "404 Resource Not Found", error.message
        end
      end

      context 'get_endpoint with success and parsable json' do 
        setup do 
          stub_request(:get, "http://user:password@localhost/path").to_return(status: 200, body: "{\"prop\":\"meh\"}")
          @response = @client.get_endpoint('path')
        end

        should 'return a hash' do 
          assert_equal 'meh', @response[:prop]
        end
      end

      context 'get_endpoint with 404' do 
        setup do 
          stub_request(:get, "http://user:password@localhost/pathtown").to_return(status: 404, body: 'errortown')
        end

        should 'throw Stingray::NotFoundError and retain rest exception' do 
          error = assert_raise(Stingray::NotFoundError){ @client.get_rest('pathtown') }
          assert error.rest_exception.is_a?(RestClient::ResourceNotFound)
          assert_equal "404 Resource Not Found", error.message
        end
      end

      context 'get_endpoint with 401 unauthorized' do 
        setup do 
          stub_request(:get, "http://user:password@localhost/pathtown").to_return(status: 401, body: 'errortown')
        end

        should 'throw Stingray::Error and retain rest exception' do 
          error = assert_raise(Stingray::Error){ @client.get_rest('pathtown') }
          assert error.rest_exception.is_a?(RestClient::Unauthorized)
          assert_equal "401 Unauthorized", error.message
        end
      end

    end

  end
end



