require 'remit/common'

module Remit
  module Settle
    class Request < Remit::Request
      action :Settle
      parameter :settlement_amount
      parameter :transaction_id
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
