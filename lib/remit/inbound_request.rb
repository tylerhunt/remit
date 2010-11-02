require 'remit/common'

module Remit

  class InboundRequest
    include ConvertKey
    extend SignatureUtilsForOutbound

    protected :convert_key

    attr_reader :supplied_signature
    attr_reader :allow_sigv1
    
    # signature key name
    SIGNATURE_KEY = 'signature'

    ##
    # +request_url+ is the full request path up to the query string, as from request.url in the controller
    # +params+ is the full params hash from the controller
    # +client+ is a fully instantiated Remit::API with access keys and sandbox settings
    #
    def initialize(request_url, params, client, options = {})
      #ensure that params is a hash
      params = params.is_a?(String) ?
              Hash.from_url_params(params) : params
      @request_url        = request_url
      #sort of assuming rails here, but needs to use pure ruby so it remains compatible with non-rails
      @params             = params.reject {|key, val| ['action','controller'].include?(key) }
      @client             = client
      @supplied_signature = @params[self.class::SIGNATURE_KEY]
      @allow_sigv1        = options[:allow_sigv1] || false
    end
    
    def valid?
      if @params['signatureVersion'].to_i == 2
        #puts "\nparams: #{@params.inspect}\n"
        return false unless InboundRequest.check_parameters(@params)
        verify_request = Remit::VerifySignature::Request.new(
          :url_end_point => @request_url,#InboundRequest.urlencode(@request_url),
          :version => Remit::API::API_VERSION,
          :http_parameters => InboundRequest.get_http_params(@params)
        )
        #puts "\nhttp_parameters: #{verify_request.http_parameters.inspect}\n"
        result = @client.verify_signature(verify_request)
        #puts "\nresult: #{result.raw.inspect}\n"
        result.verify_signature_result.verification_status == 'Success'
      elsif @params['signatureVersion'].nil? and self.allow_sigv1
        self.supplied_signature == Remit::API.signature_v1(URI.parse(@request_url).path, @params, @client.secret_key).gsub('+', ' ')
      else
        false
      end
    end
    
    def method_missing(method, *args, &block) #:nodoc:
      return @params[method.to_s] if @params.has_key?(method.to_s)
      return @params[method.to_sym] if @params.has_key?(method.to_sym)
      key = self.convert_key(method)
      return @params[key] if @params.has_key?(key)
      return @params[key.to_s] if @params.has_key?(key.to_s)
      super
    end
  end

end
