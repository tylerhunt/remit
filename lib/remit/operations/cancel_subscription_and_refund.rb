require 'remit/common'

# This operation is used by Amazon Simple Pay.
module Remit
  module CancelSubscriptionAndRefund
    class Request < Remit::Request
      action :CancelSubscriptionAndRefund
      parameter :caller_reference, :required => true
      parameter :cancel_reason
      parameter :refund_amount, :type => Remit::RequestTypes::Amount
      parameter :subscription_id, :required => true
    end

    class Response < Remit::Response
      class CancelSubscriptionAndRefundResult < Remit::BaseResponse
        parameter :refund_transaction_id
      end
      parameter :cancel_subscription_and_refund_result, :type=>CancelSubscriptionAndRefundResult
      parameter :response_metadata, :type=>ResponseMetadata
    end

    def cancel_subscription_and_refund(request = Request.new)
      call(request, Response)
    end
  end
end
