require 'remit/common'

module Remit
  module InstallPaymentInstruction
    class Request < Remit::Request
      action :InstallPaymentInstruction
      parameter :payment_instruction, :required => true
      parameter :caller_reference, :required => true
      parameter :token_friendly_name
      parameter :token_type, :required => true
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
