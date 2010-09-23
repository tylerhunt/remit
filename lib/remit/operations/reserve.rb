require 'remit/common'

module Remit
  module Reserve
    class Request < Remit::Request
      action :Reserve
      parameter :recipient_token_id, :required => true
      parameter :sender_token_id, :required => true
      parameter :sender_reference
      parameter :recipient_reference
      parameter :caller_reference, :required => true
      parameter :transaction_date
      parameter :transaction_amount, :type => Remit::RequestTypes::Amount, :required => true
      parameter :charge_fee_to, :required => true
      parameter :sender_description
      parameter :caller_description
    end

    class Response < Remit::Response
      parameter :reserve_result, :type => Remit::TransactionResponse
      parameter :response_metadata, :type=>ResponseMetadata
    end

    def reserve(request = Request.new)
      call(request, Response)
    end
  end
end
