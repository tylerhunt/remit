require File.dirname(__FILE__) + '/units_helper'

describe "the GetAccountBalance API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetAccountBalanceResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
           <GetAccountBalanceResult>
              <AccountBalance>
                 <TotalBalance>
                    <CurrencyCode>USD</CurrencyCode>
                    <Value>7.400000</Value>
                 </TotalBalance>
                 <PendingInBalance>
                    <CurrencyCode>USD</CurrencyCode>
                    <Value>0.000000</Value>
                 </PendingInBalance>
                 <PendingOutBalance>
                    <CurrencyCode>USD</CurrencyCode>
                    <Value>0.000000</Value>
                 </PendingOutBalance>
                 <AvailableBalances>
                    <DisburseBalance>
                       <CurrencyCode>USD</CurrencyCode>
                       <Value>7.400000</Value>
                    </DisburseBalance>
                    <RefundBalance>
                       <CurrencyCode>USD</CurrencyCode>
                       <Value>7.400000</Value>
                    </RefundBalance>
                 </AvailableBalances>
              </AccountBalance>
           </GetAccountBalanceResult>
           <ResponseMetadata>
              <RequestId>7b74a504-7517-4d81-8312-1427570d028c:0</RequestId>
           </ResponseMetadata>
        </GetAccountBalanceResponse>
      XML
      
      @response = Remit::GetAccountBalance::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_account_balance_result.should_not be_nil
    end
    
    describe "the result" do
      it "should have a total_balance" do
        @response.get_account_balance_result.account_balance.total_balance.value.should > 0
      end
    end
    
  end
end