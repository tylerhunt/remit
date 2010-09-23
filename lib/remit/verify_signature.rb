require 'remit/common'

module Remit
  module VerifySignature
    class Request < Remit::Request
      action :VerifySignature
      parameter :url_end_point
      parameter :http_parameters
    end

    class Response < Remit::Response
      parameter :verify_signature_result, :type => VerifySignatureResult
    end

    def verify_signature(request = Request.new)
      call(request, Response)
    end
  end
end
