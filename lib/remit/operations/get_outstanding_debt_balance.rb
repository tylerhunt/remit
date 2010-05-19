require 'remit/common'

module Remit
  module GetOutstandingDebtBalance
    class Request < Remit::Request
      action :GetOutStandingDebtBalance
    end

    class Response < Remit::Response
      class GetOutstandingDebtBalanceResult < Remit::BaseResponse
        class OutstandingDebtBalance < Remit::BaseResponse
          parameter :outstanding_balance, :type => Amount
          parameter :pending_out_balance, :type => Amount
        end
        parameter :outstanding_debt, :type => OutstandingDebtBalance
      end
      parameter :get_outstanding_debt_balance_result, :type => GetOutstandingDebtBalanceResult
      parameter :response_metadata, :type=>ResponseMetadata
    end

    def get_outstanding_debt_balance(request = Request.new)
      call(request, Response)
    end
  end
end
