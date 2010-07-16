require 'remit/common'

module Remit
  module GetRecipientVerificationStatus
    class Request < Remit::Request
      action :GetRecipientVerificationStatus
      parameter :recipient_token_id, :required => true
    end

    class Response < Remit::Response
      class GetRecipientVerificationStatusResult < Remit::BaseResponse
        parameter :recipient_verification_status
      end

      parameter :get_recipient_verification_result, :type => GetRecipientVerificationStatusResult
      parameter :response_metadata, :type=>ResponseMetadata
      
    end

    def get_debt_balance(request = Request.new)
      call(request, Response)
    end
  end
end
