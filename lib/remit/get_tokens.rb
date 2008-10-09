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
      parameter :tokens, :collection => Token
    end

    def get_tokens(request = Request.new)
      call(request, Response)
    end
  end
end
