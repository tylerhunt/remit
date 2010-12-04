require File.dirname(__FILE__) + '/units_helper'

describe "the GetRecipientVerificationStatus API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = File.read("spec/mocks/GetRecipientVerificationStatusResponse.xml")
      
      @response = Remit::GetRecipientVerificationStatus::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_recipient_verification_status_result.should_not be_nil
    end
    
    it "has status" do
      @response.get_recipient_verification_status_result.recipient_verification_status.should_not be_nil
    end
    
  end
end
