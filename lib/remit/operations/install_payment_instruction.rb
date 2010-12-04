require 'remit/common'

# This action seems to have been deprecated

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
      class InstallPaymentInstructionResult < Remit::BaseResponse
        parameter :token_id
      end
      
      parameter :install_payment_instruction_result, :type =>InstallPaymentInstructionResult
      alias :result :install_payment_instruction_result
    end

    def install_payment_instruction(request)
      call(request, Response)
    end
  end
end
