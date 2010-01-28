require 'remit/common'

module Remit
  module GetRecipientVerificationStatus
    class Request < Remit::Request
      action :GetRecipientVerificationStatus
      parameter :recipient_token_id
    end

    class Response < Remit::Response
      parameter :recipient_verification_status
    end

    def get_recipient_verification_status(request = Request.new)
      call(request, Response)
    end
  end
end
