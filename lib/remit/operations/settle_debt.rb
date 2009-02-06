require 'remit/common'

module Remit
  module SettleDebt
    class Request < Remit::Request
      action :SettleDebt
      parameter :caller_description
      parameter :caller_reference, :required => true
      parameter :caller_token_id, :required => true
      parameter :charge_fee_to, :required => true
      parameter :credit_instrument_id, :required => true
      parameter :meta_data
      parameter :recipient_description
      parameter :recipient_reference
      parameter :sender_description
      parameter :sender_reference
      parameter :sender_token_id, :required => true
      parameter :settlement_amount, :type => Remit::RequestTypes::Amount, :required => true
      parameter :transaction_date
    end

    class Response < Remit::Response
      parameter :transaction_response, :type => TransactionResponse
    end

    def settle_debt(request = Request.new)
      call(request, Response)
    end
  end
end
