require 'remit/common'

module Remit
  module RetryTransaction
    class Request < Remit::Request
      action :RetryTransaction
      parameter :original_transaction_id, :required => true
    end

    class Response < Remit::Response
      parameter :transaction_response, :type => TransactionResponse
    end

    def retry_transaction(request = Request.new)
      call(request, Response)
    end
  end
end
