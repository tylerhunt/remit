require 'base64'
require 'openssl/digest'

module Remit
  # Encapsulates the logic for IPN request validation and attribute retrieval.
  #
  # Note: if your responses from Amazon are not validating, please pass the
  # :version parameter to your original CBUI request.
  class IpnRequest
    # Signature key name used by AmazonFPS IPNs
    SIGNATURE_KEY = 'signature'

    # +params+ should be your controllers request parameters.
    def initialize(params, uri, access_key, secret_key)
      raise ArgumentError, "Expected the request params hash, received: #{params.inspect}" unless params.kind_of?(Hash)
      @params             = strip_keys_from(params, 'action', 'controller')
      @uri = URI.parse(uri)
      @url_end_point = @uri.scheme + '://' + @uri.host + @uri.path
      @access_key = access_key
      @secret_key = secret_key
    end

    def valid?
      utils = Amazon::FPS::SignatureUtilsForOutbound.new(@access_key, @secret_key);
      utils.validate_request(:parameters => @params, :url_end_point => @url_end_point, :http_method => "GET")
    end

    def method_missing(method, *args) #:nodoc:
      if @params.has_key?(method.to_s)
        @params[method.to_s]
      else
        super(method, *args)
      end
    end

    def strip_keys_from(params, *ignore_keys)
      parsed = params.dup
      ignore_keys.each { |key| parsed.delete(key) }
      parsed
    end
    private :strip_keys_from
  end
end
