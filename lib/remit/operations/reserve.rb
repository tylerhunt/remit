require 'remit/common'

module Remit
  module Reserve
    class Request < Remit::Request
      action :Reserve
      parameter :recipient_token_id, :required => true
      parameter :sender_token_id, :required => true
      parameter :caller_token_id, :required => true
      parameter :sender_reference
      parameter :recipient_reference
      parameter :caller_reference, :required => true
      parameter :transaction_date
      parameter :transaction_amount, :type => Remit::RequestTypes::Amount, :required => true
      parameter :charge_fee_to, :required => true
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
