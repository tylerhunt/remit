require 'remit/common'

module Remit
  module GetAccountBalance
    class Request < Remit::Request
      action :GetAccountBalance
    end

    class Response < Remit::Response
      class AccountBalance < Remit::BaseResponse
        class AvailableBalances < Remit::BaseResponse
          parameter :disburse_balance, :type => Amount
          parameter :refund_balance, :type => Amount
        end

        parameter :total_balance, :type => Amount
        parameter :pending_in_balance, :type => Amount
        parameter :pending_out_balance, :type => Amount
        parameter :available_balances, :type => AvailableBalances
      end

      parameter :account_balance, :type => AccountBalance
    end

    def get_account_balance(request = Request.new)
      call(request, Response)
    end
  end
end
