require 'remit/common'

module Remit
  module GetTransactionStatus
    class Request < Remit::Request
      action :GetTransaction
      parameter :transaction_id, :required => true
    end

    class Response < Remit::Response
      class GetTransactionStatusResult < Remit::BaseResponse
        
        parameter :caller_reference
        parameter :status_code
        parameter :status_message
        parameter :transaction_id
        parameter :transaction_status
       
      end

      parameter :get_transaction_status_result, :type => GetTransactionStatusResult, :element=>"GetTransactionStatusResult"
    end

    def get_transaction(request = Request.new)
      call(request, Response)
    end
  end
end
