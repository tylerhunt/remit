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

      if is?(:Response) && has?(:Errors)
        @errors = elements('Errors/Error').collect do |error|
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

    def sign_v2
      delete(:signature)
      
      sorted_keys = keys.sort { |a, b| a.to_s <=> b.to_s }
      #puts "keys = #{pp keys}"
      
      canonical_querystring = self.sort{ |a, b| a.to_s <=> b.to_s }.collect { |key, value| [CGI.escape(key.to_s), CGI.escape(value.to_s)].join('=') }.join('&')
      canonical_querystring = canonical_querystring.gsub('+','%20')
      string_to_sign = "GET
#{@uri.host}
#{@uri.path}
#{canonical_querystring}"
      signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, @secret_key, string_to_sign)).strip
      
      store(:signature,signature)
      #puts "signature = #{signature}"
      #return signature
    end



    def to_s(signed=true)
      sign_v2 if signed
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
  
  class VerifySignature
    require 'open-uri'
    require 'cgi'

    attr_reader :valid
    
    def initialize( api, uri, params = nil )
      begin
        params = uri.split('?', 2)[1] unless params
        #puts "params = #{params}"
        service_url = api.endpoint.to_s + "?Action=VerifySignature&UrlEndPoint=" + CGI.escape(uri.split('?', 2)[0]) +
          "&HttpParameters=" + CGI.escape(params) + "&Version=" + Remit::API::API_VERSION
        
        msg = "Checking signature against: #{service_url}"
        if defined?(Rails)
          Rails.logger.info msg
        else
          STDOUT.puts msg
        end
        puts "trying to open #{service_url}" 
        open( service_url ) {|f| @valid = ( f.read =~ %r{<VerificationStatus>Success</VerificationStatus>})}
      rescue Exception => e
        if defined?(Rails)
          Rails.logger.error $!.message
          Rails.logger.error $!.backtrace.join("\n\t")
        else
          STDERR.puts( $!.message )
          STDERR.puts( $!.backtrace.join("\n\t") )
        end
      end
    end
  end
end
