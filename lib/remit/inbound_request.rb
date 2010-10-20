require 'remit/common'

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
      #sort of assuming rails here, but needs to use pure ruby so it remains compatible with non-rails
      @params             = params.reject {|key, val| ['action','controller'].include?(key) }
      @supplied_signature = @params[self.class::SIGNATURE_KEY]
      @client             = client
      @allow_sigv1        = options[:allow_sigv1] || false
    end
    
    def valid?
      if @params['signatureVersion'].to_i == 2
        verify_request = Remit::VerifySignature::Request.new(
          :url_end_point => @request_url,
          :http_parameters => @params.reject {|key, val| ['action','controller'].include?(key) }.to_url_params
        )
        puts "verify_request: #{verify_request.inspect}"
        result = @client.verify_signature(verify_request)
        puts "result:\n#{result.inspect}"
        result.verify_signature_result.verification_status == 'Success'
      elsif @params['signatureVersion'].blank? and self.allow_sigv1
        self.supplied_signature == Remit::API.signature_v1(URI.parse(@request_url).path, @params, @client.secret_key).gsub('+', ' ')
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
