require 'remit/common'

#This action seems to have been deprecated

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
