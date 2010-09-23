require 'remit/common'

module Remit
  module Cancel
    class Request < Remit::Request
      action :Cancel
      parameter :transaction_id, :required => true
      parameter :description
    end

    class Response < Remit::Response
      parser :rexml
      parameter :transaction_response, :type => Remit::TransactionResponse
    end

    def cancel(request = Request.new)
      call(request, Response)
    end
  end
end
