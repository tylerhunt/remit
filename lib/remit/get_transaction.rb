require 'remit/common'

module Remit
  module GetTransaction
    class Request < Remit::Request
      action :GetTransaction
      parameter :transaction_id, :required => true
    end

    class Response < Remit::Response
      class TransactionDetail < Remit::BaseResponse
        parameter :caller_name
        parameter :caller_token_id
        parameter :caller_transaction_date, :type => :time
        parameter :date_completed, :type => :time
        parameter :date_received, :type => :time
        parameter :error_code
        parameter :error_message
        parameter :fees, :type => Amount
        parameter :meta_data
        parameter :operation
        parameter :payment_method
        parameter :recipient_name
        parameter :recipient_token_id
        parameter :related_transactions
        parameter :sender_name
        parameter :sender_token_id
        parameter :status
        parameter :status_history
        parameter :transaction_amount, :type => Amount
        parameter :transaction_id
        parameter :transaction_parts
      end

      parameter :transaction, :type => TransactionDetail
    end

    def get_transaction(request = Request.new)
      call(request, Response)
    end
  end
end
