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
    def valid?
      return false unless given_signature
      Relax::Query.unescape_value(correct_signature) == given_signature
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
      request_query[:awsSignature]
    end
    private :given_signature

    def correct_signature
      Remit::SignedQuery.new(@uri.path, @secret_key, request_query).sign
    end
    private :correct_signature
  end
end
