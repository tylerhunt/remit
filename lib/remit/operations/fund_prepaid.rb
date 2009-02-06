require 'remit/common'

module Remit
  module FundPrepaid
    class Request < Remit::Request
      action :FundPrepaid
      parameter :transaction_ids
      parameter :caller_description
      parameter :caller_reference, :required => true
      parameter :caller_token_id, :required => true
      parameter :charge_fee_to, :required => true
      parameter :funding_amount, :type => Remit::RequestTypes::Amount, :required => true
      parameter :meta_data
      parameter :prepaid_instrument_id, :required => true
      parameter :recipient_description
      parameter :recipient_reference
      parameter :sender_description
      parameter :sender_reference
      parameter :sender_token_id, :required => true
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
