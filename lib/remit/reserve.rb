require 'remit/common'

module Remit
  module Reserve
    class Request < Remit::Request
      action :Reserve
      parameter :recipient_token_id
      parameter :sender_token_id
      parameter :caller_token_id
      parameter :sender_reference
      parameter :recipient_reference
      parameter :caller_reference
      parameter :transaction_date
      parameter :transaction_amount
      parameter :charge_fee_to
      parameter :sender_description
      parameter :recipient_description
      parameter :caller_description
      parameter :meta_data
    end

    class Response < Remit::Response
      parameter :transaction_response, :type => TransactionResponse
    end

    def reserve(request = Request.new)
      call(request, Response)
    end
  end
end
