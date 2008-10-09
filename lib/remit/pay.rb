require 'remit/common'

module Remit
  module Pay
    class Request < Remit::Request
      action :Pay
      parameter :caller_description
      parameter :caller_reference
      parameter :caller_token_id
      parameter :charge_fee_to
      parameter :meta_data
      parameter :recipient_description
      parameter :recipient_reference
      parameter :recipient_token_id
      parameter :sender_description
      parameter :sender_reference
      parameter :sender_token_id
      parameter :transaction_amount, :type => Remit::RequestTypes::Amount
      parameter :transaction_date
    end

    class Response < Remit::Response
      # FIXME: Due to an issue with Hpricot, Relax-0.0.4, and namespaces, the
      # transaction_response parameter is not parsed correctly and will always
      # be nil (http://groups.google.com/group/remit/t/1e0af072200d1bb3).
      # The suggested course of action is to operate on the raw XML.
      parameter :transaction_response, :type => TransactionResponse
    end

    def pay(request = Request.new)
      call(request, Response)
    end
  end
end
