require 'remit/common'

module Remit
  module GetTokenUsage
    class Request < Remit::Request
      action :GetTokenUsage
      parameter :token_id, :required => true
    end

    class Response < Remit::Response
      class GetTokenUsageResult < Remit::BaseResponse
        parameter :token_usage_limits, :type => TokenUsageLimit
      end
      parameter :get_token_usage_result, :type=>GetTokenUsageResult
      parameter :response_metadata, :type=>ResponseMetadata
    end

    def get_token_usage(request = Request.new)
      call(request, Response)
    end
  end
end
