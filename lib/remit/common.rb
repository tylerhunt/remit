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

  class Response < BaseResponse
    parameter :request_id

    attr_accessor :status
    attr_accessor :errors

    def initialize(xml)
      super

      if is?(:Response) && has?(:Errors)
        @errors = elements(:Errors).collect do |error|
          Error.new(error)
        end
      else
        @status = text_value(element(:Status))
        @errors = elements('Errors/Errors').collect do |error|
          ServiceError.new(error)
        end unless successful?
      end
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

  class SignedQuery < Relax::Query
    def initialize(uri, secret_key, query={})
      super(query)
      @uri = URI.parse(uri.to_s)
      @secret_key = secret_key
    end

    def sign
      delete(:awsSignature)
      store(:awsSignature, Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, @secret_key, "#{@uri.path}?#{to_s(false)}".gsub('%20', '+'))).strip)
    end

    def to_s(signed=true)
      sign if signed
      super()
    end

    class << self
      def parse(uri, secret_key, query_string)
        query = self.new(uri, secret_key)

        query_string.split('&').each do |parameter|
          key, value = parameter.split('=', 2)
          query[key] = unescape_value(value)
        end

        query
      end
    end
  end
end
