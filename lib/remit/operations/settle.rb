require 'remit/common'

module Remit
  module Settle
    class Request < Remit::Request
      action :Settle
      parameter :reserve_transaction_id, :required => true
      parameter :transaction_amount, :type => Remit::RequestTypes::Amount
      parameter :transaction_date
    end

    class Response < Remit::Response
      parameter :transaction_response, :type => TransactionResponse
    end

    def settle(request = Request.new)
      call(request, Response)
    end
  end
end
