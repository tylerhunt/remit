require File.dirname(__FILE__) + '/units_helper'

describe "the GetRecipientVerificationStatus API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetRecipientVerificationStatusResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <GetRecipientVerificationStatusResult>
            <RecipientVerificationStatus>VerificationComplete</RecipientVerificationStatus>
          </GetRecipientVerificationStatusResult>
          <ResponseMetadata>
            <RequestId>b0c46f6d-dd91-464f-b37d-44be250866b7:0</RequestId>
          </ResponseMetadata>
        </GetRecipientVerificationStatusResponse>
      XML
      
      @response = Remit::GetRecipientVerificationStatus::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_recipient_verification_status_result.should_not be_nil
    end
    
    it "has status" do
      @response.get_recipient_verification_status_result.recipient_verification_status.should == 'VerificationComplete'
    end
    
  end
end