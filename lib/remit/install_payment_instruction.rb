require 'remit/common'

module Remit
  module InstallPaymentInstruction
    class Request < Remit::Request
      action :InstallPaymentInstruction
      parameter :payment_instruction
      parameter :caller_reference
      parameter :token_friendly_name
      parameter :token_type
      parameter :payment_reason
    end

    class Response < Remit::Response
      parameter :token_id
    end

    def install_payment_instruction(request)
      call(request, Response)
    end
  end
end
