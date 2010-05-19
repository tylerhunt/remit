require File.dirname(__FILE__) + '/units_helper'

describe "the GetPrepaidBalance API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetPrepaidBalanceResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <GetPrepaidBalanceResult>
            <PrepaidBalance>
              <AvailableBalance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>2.000000</Value>
              </AvailableBalance>
              <PendingInBalance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>0.000000</Value>
              </PendingInBalance>
            </PrepaidBalance>
          </GetPrepaidBalanceResult>
          <ResponseMetadata>
            <RequestId>f04c9ea5-13a2-4379-9129-39cbbad7bcfe:0</RequestId>
          </ResponseMetadata>
        </GetPrepaidBalanceResponse>
      XML
      
      @response = Remit::GetPrepaidBalance::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_prepaid_balance_result.should_not be_nil
    end
    
    describe "the result" do
      it "should have refund_transaction_id" do
        @response.get_prepaid_balance_result.prepaid_balance.available_balance.value.should > 0
      end
    end
    
    
  end
end