module Remit

  class InboundRequest
    attr_reader :supplied_signature
    attr_reader :allow_sigv1
    
    # signature key name
    SIGNATURE_KEY = 'signature'
    
    def initialize(request_url, params, secret_key, options = {})
      @request_url        = request_url
      @params             = params.dup.except('action', 'controller')
      @supplied_signature = @params.delete(self.class::SIGNATURE_KEY)
      @secret_key         = secret_key
      @allow_sigv1        = options[:allow_sigv1] || false
    end
    
    def valid?
      supplied_signature and allowed_signatures.include? supplied_signature
    end
    
    def method_missing(method, *args, &block) #:nodoc:
      return @params[method.to_s] if @params.has_key?(method.to_s)
      super
    end

    protected

    def allowed_signatures
      signatures = []
      signatures << Remit::SignedQuery.new(@request_url, @secret_key, @params)[:signature]
      signatures << Remit::API.signature_v1(URI.parse(@request_url).path, @params, @secret_key).gsub('+', ' ') if allow_sigv1
      signatures
    end
  end

end
