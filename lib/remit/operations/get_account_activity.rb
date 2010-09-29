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
      class GetAccountActivityResult < Remit::BaseResponse
        parameter :batch_size
        parameter :transactions, :collection => Transaction, :element=>"Transaction"
        parameter :start_time_for_next_transaction, :type => :time
      end
      parameter :get_account_activity_result, :type => GetAccountActivityResult
    end

    def get_account_activity(request = Request.new)
      call(request, Response)
    end
  end
end
