require 'remit/common'

module Remit
  module GetAllCreditInstruments
    class Request < Remit::Request
      action :GetAllCreditInstruments
      parameter :instrument_status
    end

    class Response < Remit::Response
      parameter :credit_instrument_ids
    end

    def get_all_credit_instruments(request = Request.new)
      call(request, Response)
    end
  end
end
