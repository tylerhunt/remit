module Remit
  module VerifySignature
    class Request < Remit::Request
      action :VerifySignature
      parameter :url_end_point, :required => true
      parameter :http_parameters, :required => true
      parameter :version, :required => true
    end

    class Response < Remit::Response
      class VerifySignatureResult < BaseResponse
        parameter :verification_status
      end
      parameter :verify_signature_result, :type => VerifySignatureResult
    end

    def verify_signature(request = Request.new)
      call(request, Response)
    end
  end
end
