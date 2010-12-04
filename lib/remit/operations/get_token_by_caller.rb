require 'remit/common'

module Remit
  module GetTokenByCaller
    class Request < Remit::Request
      action :GetTokenByCaller
      parameter :caller_reference
      parameter :token_id
    end

    class Response < Remit::Response
      class GetTokenByCallerResult < Remit::BaseResponse
        parameter :token, :type => Token
      end
      parameter :get_token_by_caller_result, :type=>GetTokenByCallerResult
      parameter :response_metadata, :type=>ResponseMetadata
    end

    def get_token_by_caller(request = Request.new)
      call(request, Response)
    end
  end
end
