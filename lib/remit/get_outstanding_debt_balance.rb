require 'remit/common'

module Remit
  module GetOutstandingDebtBalance
    class Request < Remit::Request
      action :GetOutStandingDebtBalance
    end

    class Response < Remit::Response
      class OutstandingDebtBalance < Remit::BaseResponse
        parameter :outstanding_balance, :type => Amount
        parameter :pending_out_balance, :type => Amount
      end

      parameter :outstanding_debt, :type => OutstandingDebtBalance
    end

    def get_outstanding_debt_balance(request = Request.new)
      call(request, Response)
    end
  end
end
