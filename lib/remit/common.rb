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

    protected

    def convert_key(key)
      key.to_s.gsub(/(^|_)(.)/) { $2.upcase }.to_sym
    end
  end

  class BaseResponse < Relax::Response
    private

    def node_name(name)
      name.to_s.gsub(/(^|_)(.)/) { $2.upcase }
    end
  end

  class Response < BaseResponse
    parameter :request_id
    attr_accessor :status
    attr_accessor :errors

    def initialize(xml)
      super

      if is?(:Response) and has?(:Errors)
        @errors = elements(:Errors).collect do |error|
          Error.new(error)
        end
      else
        @status = text_value(element(:Status))
        @errors = elements('errors/errors').collect do |error|
          ServiceError.new(error)
        end if not successful?
      end
    end

    def successful?
      @status == ResponseStatus::SUCCESS
    end

    private

    def node_name(name)
      name.to_s.gsub(/(^|_)(.)/) { $2.upcase }
    end
  end

  class SignedQuery < Relax::Query
    def initialize(uri, secret_key, query = {})
      super(query)
      @uri = URI.parse(uri.to_s)
      @secret_key = secret_key
    end

    def sign
      delete_if { |key, value| key == :awsSignature }
      store(:awsSignature, Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, @secret_key, "#{@uri.path}?#{to_s(false)}".gsub('%20', '+'))).strip)
    end

    def to_s(signed = true)
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
