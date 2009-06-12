require 'remit/common'

module Remit
  module Cancel
    class Request < Remit::Request
      action :Cancel
      parameter :transaction_id
      parameter :description
    end

    class Response < Remit::Response
    end

    def cancel(request = Request.new)
      call(request, Response)
    end
  end
end
