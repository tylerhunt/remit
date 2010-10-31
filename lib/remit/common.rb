require 'base64'
require 'erb'
require 'uri'

require 'rubygems'
require 'relax'

module Remit

  module ConvertKey
    def convert_key(key)
      key.to_s.gsub(/(^|_)(.)/) { $2.upcase }.to_sym
    end
  end

  class Request < Relax::Request
    def self.action(name)
      parameter :action, :value => name
    end

    include ConvertKey
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

    def node_name(name, namespace=nil)
      super(name.to_s.split('/').collect{ |tag|
        tag.gsub(/(^|_)(.)/) { $2.upcase }
      }.join('/'), namespace)
    end
  end

  class SignedQuery < Relax::Query
    def initialize(uri, secret_key, query = {})
      super(query)
      @uri = URI.parse(uri.to_s)
      @secret_key = secret_key
      sign
    end

    def sign
      store(:signatureVersion, Remit::API::SIGNATURE_VERSION)
      store(:signatureMethod, Remit::API::SIGNATURE_METHOD)
      store(:signature, signature)
    end

    def signature
      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, @secret_key, signable_string)).strip
    end

    def signable_string
      [ 'GET',
        @uri.host,
        @uri.path,
        to_s # the query string, sans :signature (but with :signatureVersion and :signatureMethod)
      ].join("\n")
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

      UNSAFE = /[^A-Za-z0-9_.~-]/
      # Amazon is very specific about what chars should be escaped, and which should not.
      def escape_value(value)
        # note that URI.escape(' ') => '%20', and CGI.escape(' ') => '+'
        URI.escape(value.to_s, UNSAFE)
      end
    end
  end

  # Frustratingly enough, API requests want the signature params with slightly different casing.
  class ApiQuery < SignedQuery
    def sign
      store(:SignatureVersion, Remit::API::SIGNATURE_VERSION)
      store(:SignatureMethod, 'HmacSHA256')
      store(:Signature, signature)
    end
  end
end

#Hack on Hash to make it s rocket
class Hash
  def to_url_params
    elements = []
    keys.size.times do |i|
      elements << "#{(keys[i])}=#{Remit::SignedQuery.escape_value(values[i])}"
    end
    elements.join('&')
  end

  def self.from_url_params(url_params)
    result = {}
    url_params.split('&').each do |element|
      element = element.split('=')
      result[element[0]] = element[1]
    end
    result
  end
end
