require 'remit/common'

module Remit
  module Refund
    class Request < Remit::Request
      action :Refund
      parameter :caller_description
      parameter :caller_reference, :required => true
      parameter :caller_token_id, :required => true
      parameter :charge_fee_to, :required => true
      parameter :meta_data
      parameter :refund_amount, :type => Remit::RequestTypes::Amount
      parameter :refund_recipient_description
      parameter :refund_recipient_reference
      parameter :refund_sender_description
      parameter :refund_sender_reference
      parameter :refund_sender_token_id, :required => true
      parameter :transaction_date
      parameter :transaction_id, :required => true

      # The RefundAmount parameter has multiple components.  It is specified on the query string like
      # so: RefundAmount.Amount=XXX&RefundAmount.CurrencyCode=YYY
      def convert_complex_key(key, parameter)
        "#{convert_key(key).to_s}.#{convert_key(parameter).to_s}"
      end
    end

    class Response < Remit::Response
      parser :rexml
      parameter :transaction_response, :namespace => 'ns3', :type => TransactionResponse
    end

    def refund(request = Request.new)
      call(request, Response)
    end
  end
end
