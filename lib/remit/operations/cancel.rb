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
      parameter :transaction_response, :namespace => 'ns3', :type => TransactionResponse
    end

    def cancel(request = Request.new)
      call(request, Response)
    end
  end
end