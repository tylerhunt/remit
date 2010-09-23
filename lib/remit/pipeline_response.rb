module Remit

  class PipelineResponse < InboundRequest
    # signature key name
    SIGNATURE_KEY = 'awsSignature'
    
    def successful?
      [
        Remit::PipelineStatusCode::SUCCESS_UNCHANGED,
        Remit::PipelineStatusCode::SUCCESS_ABT,
        Remit::PipelineStatusCode::SUCCESS_ACH,
        Remit::PipelineStatusCode::SUCCESS_CC,
        Remit::PipelineStatusCode::SUCCESS_RECIPIENT_TOKEN_INSTALLED
      ].include?(@params[:status])
    end
  end

end
