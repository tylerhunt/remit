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
        parameter :operation_type
        parameter :caller_reference
        parameter :transaction_status
      end

      parameter :transaction_results, :type => TransactionResults
    end

    def get_results(request = Request.new)
      call(request, Response)
    end
  end
end
