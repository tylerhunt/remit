require File.dirname(__FILE__) + '/units_helper'

describe "the GetDebtBalance API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetDebtBalanceResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <GetDebtBalanceResult>
            <DebtBalance>
              <AvailableBalance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>5.000000</Value>
              </AvailableBalance>
              <PendingOutBalance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>0.000000</Value>
              </PendingOutBalance>
            </DebtBalance>
          </GetDebtBalanceResult>
          <ResponseMetadata>
            <RequestId>73f8efcd-0ea3-4015-b7da-5da1b1111b82:0</RequestId>
          </ResponseMetadata>
        </GetDebtBalanceResponse>
      XML
      
      @response = Remit::GetDebtBalance::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_debt_balance_result.should_not be_nil
    end
    
    describe "the result" do
      it "should have an available_balance" do
        @response.get_debt_balance_result.debt_balance.available_balance.value.should > 0
      end
    end
    
    
  end
end