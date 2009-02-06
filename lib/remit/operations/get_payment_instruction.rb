require 'remit/common'

module Remit
  module GetPaymentInstruction
    class Request < Remit::Request
      action :GetPaymentInstruction
      parameter :token_id, :required => true
    end

    class Response < Remit::Response
      parameter :token, :type => Token
      parameter :payment_instruction
      parameter :account_id
      parameter :token_friendly_name
    end

    def get_payment_instruction(request = Request.new)
      call(request, Response)
    end
  end
end
