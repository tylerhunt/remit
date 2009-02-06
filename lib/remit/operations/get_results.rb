require 'remit/common'

module Remit
  module GetResults
    class Request < Remit::Request
      action :GetResults
      parameter :operation
      parameter :max_results_count
    end

    class Response < Remit::Response
      class TransactionResults < Remit::BaseResponse
        parameter :transaction_id
        parameter :operation_type, :element => :operation
        parameter :caller_reference
        parameter :transaction_status, :element => :status
      end

      parameter :transaction_results, :collection => TransactionResults
      parameter :number_pending, :type => :integer
    end

    def get_results(request = Request.new)
      call(request, Response)
    end
  end
end
