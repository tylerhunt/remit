require 'remit/common'

module Remit
  module GetDebtBalance
    class Request < Remit::Request
      action :GetDebtBalance
      parameter :credit_instrument_id, :required => true
    end

    class Response < Remit::Response
      class GetDebtBalanceResult < Remit::BaseResponse
        class DebtBalance < Remit::BaseResponse
          parameter :available_balance, :type => Amount
          parameter :pending_out_balance, :type => Amount
        end
        parameter :debt_balance, :type => DebtBalance
      end

      parameter :get_debt_balance_result, :type => GetDebtBalanceResult
      parameter :response_metadata, :type=>ResponseMetadata
      
    end

    def get_debt_balance(request = Request.new)
      call(request, Response)
    end
  end
end
