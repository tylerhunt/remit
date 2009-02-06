require 'remit/common'

module Remit
  module GetAccountActivity
    class Request < Remit::Request
      action :GetAccountActivity
      parameter :start_date, :required => true
      parameter :end_date
      parameter :max_batch_size
      parameter :sort_order_by_date
      parameter :response_group
      parameter :operation
      parameter :payment_method
      parameter :role
      parameter :status
    end

    class Response < Remit::Response
      class Transaction < Remit::BaseResponse
        class TransactionPart < Remit::BaseResponse
          parameter :account_id
          parameter :role
          parameter :name
          parameter :reference
          parameter :description
          parameter :fee_paid, :type => Amount
        end

        parameter :caller_name
        parameter :caller_token_id
        parameter :caller_transaction_date, :type => :time
        parameter :date_completed, :type => :time
        parameter :date_received, :type => :time
        parameter :error_code
        parameter :error_detail
        parameter :error_message
        parameter :fees, :type => Amount
        parameter :meta_data
        parameter :operation
        parameter :original_transaction_id
        parameter :payment_method
        parameter :recipient_name
        parameter :sender_name
        parameter :sender_token_id
        parameter :status
        parameter :transaction_amount, :type => Amount
        parameter :transaction_id
        parameter :transaction_parts, :collection => TransactionPart
      end

      parameter :response_batch_size
      parameter :transactions, :collection => Transaction
      parameter :start_time_for_next_transaction, :type => :time
    end

    def get_account_activity(request = Request.new)
      call(request, Response)
    end
  end
end
