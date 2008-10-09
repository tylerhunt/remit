require 'remit/common'

module Remit
  module UnsubscribeForCallerNotification
    class Request < Remit::Request
      action :UnSubscribeForCallerNotification
      parameter :notification_operation_name
    end

    class Response < Remit::Response
    end

    def unsubscribe_for_caller_notification(request = Request.new)
      call(request, Response)
    end
  end
end
