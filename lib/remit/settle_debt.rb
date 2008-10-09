require 'remit/common'

module Remit
  module SettleDebt
    class Request < Remit::Request
      action :SettleDebt
      parameter :caller_description
      parameter :caller_reference
      parameter :caller_token_id
      parameter :charge_fee_to
      parameter :credit_instrument_id
      parameter :meta_data
      parameter :recipient_description
      parameter :recipient_reference
      parameter :sender_description
      parameter :sender_reference
      parameter :sender_token_id
      parameter :settlement_amount
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
