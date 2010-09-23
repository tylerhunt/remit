module Remit

  class InboundRequest
    attr_reader :supplied_signature
    
    # signature key name
    SIGNATURE_KEY = 'signature'
    
    def initialize(request_url, params, secret_key)
      @request_url        = request_url
      @params             = params.dup.except('action', 'controller')
      @supplied_signature = @params.delete(self.class::SIGNATURE_KEY)
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
      @expected_signature ||= Remit::SignedQuery.new(@request_url, @secret_key, @params)[:signature]
    end
  end

end
