require 'remit/common'

module Remit
  module FundPrepaid
    class Request < Remit::Request
      action :FundPrepaid
      parameter :transaction_ids
      parameter :caller_description
      parameter :caller_reference, :required => true
      parameter :funding_amount, :type => Remit::RequestTypes::Amount, :required => true
      parameter :prepaid_instrument_id, :required => true
      parameter :recipient_reference
      parameter :sender_description
      parameter :sender_reference
      parameter :sender_token_id, :required => true
      parameter :transaction_date
    end

    class Response < Remit::Response
      class FundPrepaidResult < Remit::BaseResponse
        parameter :transaction_id
        parameter :transaction_status
      end
      parameter :fund_prepaid_result, :type => FundPrepaidResult
      parameter :response_metadata, :type=>ResponseMetadata
    end

    def fund_prepaid(request = Request.new)
      call(request, Response)
    end
  end
end
