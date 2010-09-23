require 'base64'
require 'openssl/digest'

module Remit
  
  ##
  # Encapsulates the logic for IPN request validation and attribute retrieval.
  # 
  class IpnRequest
    attr_reader :supplied_signature
    
    # Signature key name used by AmazonFPS IPNs
    SIGNATURE_KEY = 'signature'
    
    ##
    # +params+ should be your controllers request parameters.
    # 
    def initialize(request, params, secret_key)
      raise ArgumentError, "Expected the request params hash, received: #{params.inspect}" unless params.kind_of?(Hash)
      @request            = request
      @params             = params.dup.except('action', 'controller')
      @supplied_signature = @params.delete(SIGNATURE_KEY)
      @secret_key         = secret_key
    end
    
    def valid?
      supplied_signature and expected_signature == supplied_signature
    end
    
    def method_missing(method, *args, &block) #:nodoc:
      return @params[method.to_s] if @params.has_key?(method.to_s)
      super
    end
    
    def expected_signature
      @expected_signature ||= Remit::SignedQuery.new(@request.url, @secret_key, @params)[:signature]
    end
  end
  
end
