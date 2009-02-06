require 'remit/common'

module Remit
  module DiscardResults
    class Request < Remit::Request
      action :DiscardResults
      parameter :transaction_ids, :required => true
    end

    class Response < Remit::Response
      parameter :discard_errors
    end

    def discard_results(request = Request.new)
      call(request, Response)
    end
  end
end
