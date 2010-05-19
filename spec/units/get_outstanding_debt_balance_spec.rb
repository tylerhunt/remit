require File.dirname(__FILE__) + '/units_helper'

describe "the GetOutstandingDebtBalance API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetOutstandingDebtBalanceResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <GetOutstandingDebtBalanceResult>
            <OutstandingDebt>
              <OutstandingBalance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>5.000000</Value>
              </OutstandingBalance>
              <PendingOutBalance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>0.000000</Value>
              </PendingOutBalance>
            </OutstandingDebt>
          </GetOutstandingDebtBalanceResult>
          <ResponseMetadata>
            <RequestId>ae85ac11-a38c-4c42-94fc-b71c9598c76f:0</RequestId>
          </ResponseMetadata>
        </GetOutstandingDebtBalanceResponse>
      XML
      
      @response = Remit::GetOutstandingDebtBalance::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_outstanding_debt_balance_result.should_not be_nil
    end
    
    describe "the result" do
      it "should have refund_transaction_id" do
        @response.get_outstanding_debt_balance_result.outstanding_debt.outstanding_balance.value.should > 0
      end
    end
    
    
  end
end