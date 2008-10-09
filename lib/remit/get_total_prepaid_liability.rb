require 'remit/common'

module Remit
  module GetTotalPrepaidLiability
    class Request < Remit::Request
      action :GetTotalPrepaidLiability
    end

    class Response < Remit::Response
      class OutstandingPrepaidLiability < Remit::BaseResponse
        parameter :outstanding_balance, :type => Amount
        parameter :panding_in_balance, :type => Amount
      end

      parameter :outstanding_prepaid_liability, :type => OutstandingPrepaidLiability
    end

    def get_total_prepaid_liability(request = Request.new)
      call(request, Response)
    end
  end
end
