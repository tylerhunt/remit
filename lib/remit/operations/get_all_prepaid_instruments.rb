require 'remit/common'

module Remit
  module GetAllPrepaidInstruments
    class Request < Remit::Request
      action :GetAllPrepaidInstruments
      parameter :instrument_status
    end

    class Response < Remit::Response
      parameter :prepaid_instrument_ids
    end

    def get_all_prepaid_instruments(request = Request.new)
      call(request, Response)
    end
  end
end
