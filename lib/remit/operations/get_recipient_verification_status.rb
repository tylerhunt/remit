require 'remit/common'

module Remit
  module GetRecipientVerificationStatus
    class Request < Remit::Request
      action :GetRecipientVerificationStatus
      parameter :recipient_token_id, :required => true
    end

    class Response < Remit::Response
      parser :rexml
      class GetRecipientVerificationStatusResult < Remit::BaseResponse
        parameter :recipient_verification_status
      end

      parameter :get_recipient_verification_status_result, :type => GetRecipientVerificationStatusResult
      parameter :response_metadata, :type=>ResponseMetadata
      
    end

    def get_recipient_verification_status(request = Request.new)
      call(request, Response)
    end
  end
end
