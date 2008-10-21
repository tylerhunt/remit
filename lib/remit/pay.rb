require 'remit/common'

module Remit
  module Pay
    class Request < Remit::Request
      action :Pay
      parameter :caller_description
      parameter :caller_reference
      parameter :caller_token_id
      parameter :charge_fee_to
      parameter :meta_data
      parameter :recipient_description
      parameter :recipient_reference
      parameter :recipient_token_id
      parameter :sender_description
      parameter :sender_reference
      parameter :sender_token_id
      parameter :transaction_amount, :type => Remit::RequestTypes::Amount
      parameter :transaction_date
    end

    class Response < Remit::Response
      parser :rexml
      parameter :transaction_response, :namespace => 'ns3', :type => TransactionResponse
    end

    def pay(request = Request.new)
      call(request, Response)
    end
  end
end
