module Remit

  class InboundRequest
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
      @request_url        = request_url
      @params             = params.dup.except('action', 'controller')
      @supplied_signature = @params.delete(self.class::SIGNATURE_KEY)
      @client             = client
      @allow_sigv1        = options[:allow_sigv1] || false
    end
    
    def valid?
      if @params['signatureVersion'].to_i == 2
        result = @client.verify_signature(Remit::VerifySignature::Request.new(
          :url_end_point => @request_url,
          :http_parameters => @params.except('action', 'controller', 'id').to_params
        ))
        result.verify_signature_result.verification_status == 'Success'
      elsif @params['signatureVersion'].blank? and allow_sigv1
        supplied_signature == Remit::API.signature_v1(URI.parse(@request_url).path, @params, @client.secret_key).gsub('+', ' ')
      else
        false
      end
    end
    
    def method_missing(method, *args, &block) #:nodoc:
      return @params[method.to_s] if @params.has_key?(method.to_s)
      super
    end
  end

end
