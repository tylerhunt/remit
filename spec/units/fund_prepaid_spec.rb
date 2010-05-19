require File.dirname(__FILE__) + '/units_helper'

describe "the FundPrepaid API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <FundPrepaidResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <FundPrepaidResult>
            <TransactionId>14GN2BUHUAV4KG5S8USHN79PQH1NGN5ADK4</TransactionId>
            <TransactionStatus>Pending</TransactionStatus>
          </FundPrepaidResult>
          <ResponseMetadata>
            <RequestId>325c3342-a972-4d73-9e28-c56442ad56de:0</RequestId>
          </ResponseMetadata>
        </FundPrepaidResponse>
      XML
      
      @response = Remit::FundPrepaid::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.fund_prepaid_result.should_not be_nil
    end
    
    
  end
end