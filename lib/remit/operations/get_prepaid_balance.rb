require 'remit/common'

module Remit
  module GetPrepaidBalance
    class Request < Remit::Request
      action :GetPrepaidBalance
      parameter :prepaid_instrument_id, :required => true
    end

    class Response < Remit::Response
      class GetPrepaidBalanceResult < Remit::BaseResponse
        class PrepaidBalance < Remit::BaseResponse
          parameter :available_balance, :type => Amount
          parameter :pending_in_balance, :type => Amount
        end
  
        parameter :prepaid_balance, :type => PrepaidBalance
      end
      parameter :get_prepaid_balance_result, :type=>GetPrepaidBalanceResult
      parameter :response_metadata, :type=>ResponseMetadata
    end

    def get_prepaid_balance(request = Request.new)
      call(request, Response)
    end
  end
end
