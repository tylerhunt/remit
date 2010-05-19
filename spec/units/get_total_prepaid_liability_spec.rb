require File.dirname(__FILE__) + '/units_helper'

describe "the GetTotalPrepaidLiability API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetTotalPrepaidLiabilityResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <GetTotalPrepaidLiabilityResult>
            <OutstandingPrepaidLiability>
              <OutstandingBalance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>2.000000</Value>
              </OutstandingBalance>
              <PendingInBalance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>0.000000</Value>
              </PendingInBalance>
            </OutstandingPrepaidLiability>
          </GetTotalPrepaidLiabilityResult>
          <ResponseMetadata>
            <RequestId>ac7b28ea-c340-4638-be46-d4a8fa54a801:0</RequestId>
          </ResponseMetadata>
        </GetTotalPrepaidLiabilityResponse>
      XML
      
      @response = Remit::GetTotalPrepaidLiability::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_total_prepaid_liability_result.should_not be_nil
    end
    
    
  end
end