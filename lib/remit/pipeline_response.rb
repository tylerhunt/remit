module Remit
  class PipelineResponse
    def initialize(params, uri, access_key, secret_key)
      @params = strip_keys_from(params, 'action', 'controller', 'id')
      @uri = URI.parse(uri)
      @url_end_point = @uri.scheme + '://' + @uri.host + @uri.path
      @access_key = access_key
      @secret_key = secret_key
    end

    # Returns +true+ if the response is correctly signed (awsSignature).
    #
    #--
    # The unescape_value method is used here because the awsSignature value
    # pulled from the request is filtered through the same method.
    #++
    def valid?
      utils = Amazon::FPS::SignatureUtilsForOutbound.new(@access_key, @secret_key);
      utils.validate_request(:parameters => @params, :url_end_point => @url_end_point, :http_method => "GET")
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

    def strip_keys_from(params, *ignore_keys)
      parsed = params.dup
      ignore_keys.each { |key| parsed.delete(key) }
      parsed
    end
    private :strip_keys_from

  end
end
