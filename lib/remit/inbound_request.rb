require 'remit/common'

module Remit

  class InboundRequest
    include ConvertKey
    extend SignatureUtilsForOutbound

    protected :convert_key

    attr_reader :supplied_signature
    attr_reader :allow_sigv1
    
    # BJM: need to access sometimes from the app
    attr_reader :hash_params
    # signature key name
    SIGNATURE_KEY = 'signature'

    ##
    # +request_url+ is the full request path up to the query string, as from request.url in the controller
    # +params+ is the full params hash from the controller
    # +client+ is a fully instantiated Remit::API with access keys and sandbox settings
    #
    # Only clean params hash is params is sent as a hash.
    # Assume caller has cleaned string if string is sent as params
    def initialize(request_url, params, client, options = {})
      if params.is_a?(String)
        @string_params = params
        @hash_params = Hash.from_url_params(params)
      else
        unless options.kind_of?(Hash)
          options = {}
        end
        options[:skip_param_keys] ||= []
        #this is a bit of helpful sugar for rails framework users
        options[:skip_param_keys] |= ['action','controller']

        if params.respond_to?(:reject)
          params.reject! {|key, val| options[:skip_param_keys].include?(key) }
        else
          params = {}
        end
        @hash_params      = params
        @string_params    = InboundRequest.get_http_params(@hash_params)
      end
      puts "Params are: #{params.inspect}"
      @request_url        = request_url
      @client             = client
      @supplied_signature = @hash_params[self.class::SIGNATURE_KEY]
      @allow_sigv1        = options[:allow_sigv1] || false
    end
    
    def valid?
      if @hash_params['signatureVersion'].to_i == 2
        #puts "\nhash_params: #{@hash_params.inspect}\n"
        #puts "\nstring_params: #{@string_params.inspect}\n"
        return false unless InboundRequest.check_parameters(@hash_params)
        verify_request = Remit::VerifySignature::Request.new(
          :url_end_point => @request_url,#InboundRequest.urlencode(@request_url),
          :version => Remit::API::API_VERSION,
          :http_parameters => @string_params
        )
        #puts "\nurl_end_point#{@request_url.inspect}\n"
        #puts "\nhttp_parameters: #{verify_request.http_parameters.inspect}\n"
        result = @client.verify_signature(verify_request)
        #puts "\nresult: #{result.raw.inspect}\n"
        result.verify_signature_result.verification_status == 'Success'
      elsif @hash_params['signatureVersion'].nil? and self.allow_sigv1
        self.supplied_signature == Remit::API.signature_v1(URI.parse(@request_url).path, @hash_params, @client.secret_key).gsub('+', ' ')
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
