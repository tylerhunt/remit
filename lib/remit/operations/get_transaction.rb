require 'remit/common'

module Remit
  module GetTransaction
    class Request < Remit::Request
      action :GetTransaction
      parameter :transaction_id, :required => true
    end

    class Response < Remit::Response
      parameter :transaction, :type => Transaction, :element=>"GetTransactionResult/Transaction"
    end

    def get_transaction(request = Request.new)
      call(request, Response)
    end
  end
end
