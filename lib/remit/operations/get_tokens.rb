require 'remit/common'

module Remit
  module GetTokens
    class Request < Remit::Request
      action :GetTokens
      parameter :caller_reference
      parameter :token_friendly_name
      parameter :token_status
    end

    class Response < Remit::Response
      class GetTokensResult < Remit::BaseResponse
        parameter :tokens, :element => 'Token', :collection => Remit::Token
      end
      parameter :get_tokens_result, :type=>GetTokensResult
      parameter :response_metadata, :type=>ResponseMetadata
    end

    def get_tokens(request = Request.new)
      call(request, Response)
    end
  end
end
