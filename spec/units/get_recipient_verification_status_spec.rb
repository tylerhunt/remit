require File.dirname(__FILE__) + '/units_helper'

describe "the GetRecipientVerificationStatus API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetRecipientVerificationResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <GetRecipientVerificationResult>
            <RecipientVerificationStatus>
              VerificationComplete
            </RecipientVerificationStatus>
          </GetRecipientVerificationResult>
          <ResponseMetadata>
            <RequestId>197e2085-1ed7-47a2-93d8-d76b452acc74:0</RequestId>
          </ResponseMetadata>
        </GetRecipientVerificationResponse>
      XML
      
      @response = Remit::GetRecipientVerificationStatus::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_recipient_verification_result.should_not be_nil
    end
    
    
  end
end