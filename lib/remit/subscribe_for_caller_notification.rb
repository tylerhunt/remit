require 'remit/common'

module Remit
  module SubscribeForCallerNotification
    class Request < Remit::Request
      action :SubscribeForCallerNotification
      parameter :notification_operation_name, :required => true
      parameter :web_service_api_url, :required => true
    end

    class Response < Remit::Response
    end

    def subscribe_for_caller_notification(request = Request.new)
      call(request, Response)
    end
  end
end
