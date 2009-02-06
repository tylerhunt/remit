require 'remit/common'

module Remit
  module WriteOffDebt
    class Request < Remit::Request
      action :WriteOffDebt
      parameter :caller_token_id, :required => true
      parameter :credit_instrument_id, :required => true
      parameter :adjustment_amount, :required => true
      parameter :transaction_date
      parameter :sender_reference
      parameter :caller_reference, :required => true
      parameter :recipient_reference
      parameter :sender_description
      parameter :recipient_description
      parameter :caller_description
      parameter :meta_data
    end

    class Response < Remit::Response
      parameter :transaction_response, :type => TransactionResponse
    end

    def write_off_debt(request = Request.new)
      call(request, Response)
    end
  end
end
