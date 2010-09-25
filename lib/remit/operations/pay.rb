require 'remit/common'

module Remit
  module Pay
    class Request < Remit::Request
      action :Pay
      parameter :caller_description
      parameter :caller_reference, :required => true
      parameter :charge_fee_to, :required => true
      parameter :descriptor_policy, :type => Remit::RequestTypes::DescriptorPolicy
      parameter :marketplace_fixed_fee, :type => Remit::RequestTypes::Amount
      parameter :marketplace_variable_fee
      parameter :recipient_token_id #, Only required for MarketPlace transactions
      parameter :sender_description
      parameter :sender_token_id, :required => true
      parameter :transaction_amount, :type => Remit::RequestTypes::Amount, :required => true
      parameter :transaction_timeout_in_mins
      parameter :timestamp
    end

    # The response is odd, when it succeeds.  --JonMoses
    class Response < Remit::Response
      parser :rexml
      parameter :pay_result, :type => Remit::TransactionResponse
    end

    def pay(request = Request.new)
      call(request, Response)
    end
  end
end
