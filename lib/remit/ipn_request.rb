require 'base64'
require 'openssl/digest'

module Remit
  
  ##
  # Encapsulates the logic for IPN request validation and attribute retrieval.
  # 
  class IpnRequest
    
    # Signature key name used by AmazonFPS IPNs
    SIGNATURE_KEY = 'signature'
    
    ##
    # +params+ should be your controllers request parameters.
    # 
    def initialize(params, secret_key)
      raise ArgumentError, "Expected the request params hash, received: #{params.inspect}" unless params.kind_of?(Hash)
      @params             = strip_keys_from(params, 'action', 'controller')
      @supplied_signature = @params.delete(SIGNATURE_KEY)
      @secret_key         = secret_key
    end
    
    def valid?
      return false unless @supplied_signature
      generate_signature_for(@params) == @supplied_signature
    end
    
    def method_missing(method, *args) #:nodoc:
      if @params.has_key?(method)
        @params[method]
      else
        super(method, *args)
      end
    end
    
    
    private
    
    
    def generate_signature_for(params)
      query   = params.sort_by { |k,v| k.downcase }
      digest  = OpenSSL::Digest::Digest.new('sha1')
      hmac    = OpenSSL::HMAC.digest(digest, @secret_key, query.to_s)
      encoded = Base64.encode64(hmac).chomp
    end
    
    def strip_keys_from(params, *ignore_keys)
      parsed = params.dup
      ignore_keys.each { |key| parsed.delete(key) }
      parsed
    end
    
  end
  
end
