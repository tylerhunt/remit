require 'remit/common'

module Remit
  module Refund
    class Request < Remit::Request
      action :Refund
      parameter :caller_description
      parameter :caller_reference, :required => true
      parameter :refund_amount, :type => Remit::RequestTypes::Amount
      parameter :transaction_id, :required => true
      #MarketplaceRefundPolicy is available in these APIs:
      # Amazon FPS Advanced Quick Start
      # Amazon FPS Marketplace Quick Start
      # Amazon FPS Aggregated Payments Quick Start
      # i.e. Not Basic Quick Start
      #Amazon Docs now correctly list it as an Enumerated DataType
      parameter :marketplace_refund_policy
      parameter :timestamp
# TODO: Check these parameters in Latest FPS API
#      parameter :refund_recipient_description
#      parameter :refund_recipient_reference
#      parameter :refund_sender_description
#      parameter :refund_sender_reference
#      parameter :refund_sender_token_id
#      parameter :transaction_date

      # The RefundAmount parameter has multiple components.  It is specified on the query string like
      # so: RefundAmount.Amount=XXX&RefundAmount.CurrencyCode=YYY
      def convert_complex_key(key, parameter)
        "#{convert_key(key)}.#{convert_key(parameter)}"
      end
    end

    class Response < Remit::Response
      parser :rexml
#Namespace changed with new API:
#      parameter :transaction_response, :namespace => 'ns3', :type => TransactionResponse
      parameter :refund_result, :type => Remit::TransactionResponse
      parameter :response_metadata, :type => ResponseMetadata
    end

    def refund(request = Request.new)
      call(request, Response)
    end
  end
end
