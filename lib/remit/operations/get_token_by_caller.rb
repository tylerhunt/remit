require 'remit/common'

module Remit
  module GetTokenByCaller
    class Request < Remit::Request
      action :GetTokenByCaller
      parameter :caller_reference
      parameter :token_id
    end

    class Response < Remit::Response
      parameter :token, :type => Token
    end

    def get_token_by_caller(request = Request.new)
      call(request, Response)
    end
  end
end
