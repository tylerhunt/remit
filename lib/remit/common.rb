require 'base64'
require 'erb'
require 'uri'

require 'rubygems'
require 'relax'

module Remit
  class Request < Relax::Request
    def self.action(name)
      parameter :action, :value => name
    end

    def convert_key(key)
      key.to_s.gsub(/(^|_)(.)/) { $2.upcase }.to_sym
    end
    protected :convert_key
  end

  class BaseResponse < Relax::Response
    def node_name(name, namespace=nil)
      super(name.to_s.gsub(/(^|_)(.)/) { $2.upcase }, namespace)
    end
  end

  class ResponseMetadata < BaseResponse
    # Amazon FPS returns a RequestId element for every API call accepted for processing
    # that means not *every* call will have a request ID.
    parameter :request_id#, :required => true
    parameter :signature_version
    parameter :signature_method
  end  

  class Response < BaseResponse
    parameter :response_metadata, :type => Remit::ResponseMetadata, :required => true

    attr_accessor :status
    attr_accessor :errors

    def request_id
      self.response_metadata.respond_to?(:request_id) ? self.response_metadata.request_id : nil
    end

    def initialize(xml)
      super

#TODO: How to differentiate between Error and Service Error
#The way this is written it would always be the first branch, since this is the Response class and it is testing is is?(:Response)
#      if is?(:Response) && has?(:Errors)
#        @errors = elements('Errors/Error').collect do |error|
#          Error.new(error)
#        end
#      else
        @status = text_value(element(:Status))
        @errors = elements('Errors/Errors').collect do |error|
          ServiceError.new(error)
        end unless successful?
#      end
    end

    def successful?
      @status == ResponseStatus::SUCCESS
    end

    def node_name(name, namespace=nil)
      super(name.to_s.split('/').collect{ |tag|
        tag.gsub(/(^|_)(.)/) { $2.upcase }
      }.join('/'), namespace)
    end
  end

end
