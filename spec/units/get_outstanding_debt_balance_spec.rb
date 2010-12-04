require File.dirname(__FILE__) + '/units_helper'

describe "the GetOutstandingDebtBalance API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = File.read("spec/mocks/GetOutstandingDebtBalanceResponse.xml")
      
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
        @response.get_outstanding_debt_balance_result.outstanding_debt.outstanding_balance.value.should == 0
      end
    end
    
    
  end
end
