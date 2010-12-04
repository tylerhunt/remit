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
      ].include?(@hash_params['status']) #:status])
      # BJM: 'status' not :status

    end
  end

end
