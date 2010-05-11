module Remit
  class PipelineResponse
    def initialize(uri, secret_key)
      @uri        = URI.parse(uri)
      @secret_key = secret_key
    end

    # Returns +true+ if the response is correctly signed (awsSignature).
    #
    #--
    # The unescape_value method is used here because the awsSignature value
    # pulled from the request is filtered through the same method.
    #++
    def valid?( api = nil)
      return false unless given_signature
      # Relax::Query.unescape_value(correct_signature(api)) == given_signature
      correct_signature(api)
    end

    # Returns +true+ if the response returns a successful state.
    def successful?
      [
        Remit::PipelineStatusCode::SUCCESS_ABT,
        Remit::PipelineStatusCode::SUCCESS_ACH,
        Remit::PipelineStatusCode::SUCCESS_CC,
        Remit::PipelineStatusCode::SUCCESS_RECIPIENT_TOKEN_INSTALLED
      ].include?(request_query[:status])
    end

    def method_missing(method, *args) #:nodoc:
      if request_query.has_key?(method.to_sym)
        request_query[method.to_sym]
      else
        super
      end
    end

    def request_query(reload = false)
      @query ||= Remit::SignedQuery.parse(@uri, @secret_key, @uri.query || '')
    end
    private :request_query

    def given_signature
      request_query[:signature]
    end
    private :given_signature

    def correct_signature( api = nil)
      return nil unless api
      
      Rails.logger.debug "FPS: Computed signature: " + Remit::SignedQuery.new(@uri.path, @secret_key, request_query).sign
      Rails.logger.debug "FPS: Real signature: " + request_query[:signature]
      # Verifign a responses signature against a webservice seems....silly?
      Remit::VerifySignature.new(api, @uri.to_s).valid
    end
    private :correct_signature
  end
end
