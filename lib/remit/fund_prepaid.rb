require 'remit/common'

module Remit
  module FundPrepaid
    class Request < Remit::Request
      action :FundPrepaid
      parameter :transaction_ids
      parameter :caller_description
      parameter :caller_reference
      parameter :caller_token_id
      parameter :charge_fee_to
      parameter :funding_amount
      parameter :meta_data
      parameter :prepaid_instrument_id
      parameter :recipient_description
      parameter :recipient_reference
      parameter :sender_description
      parameter :sender_reference
      parameter :sender_token_id
      parameter :transaction_date
    end

    class Response < Remit::Response
      parameter :transaction_response, :type => TransactionResponse
    end

    def fund_prepaid(request = Request.new)
      call(request, Response)
    end
  end
end
