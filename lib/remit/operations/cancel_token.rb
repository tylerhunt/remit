require 'remit/common'

module Remit
  module CancelToken
    class Request < Remit::Request
      action :CancelToken
      parameter :token_id, :required => true
      parameter :reason_text
    end

    class Response < Remit::Response
    end

    def cancel_token(request = Request.new)
      call(request, Response)
    end
  end
end
