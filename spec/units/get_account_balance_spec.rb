require File.dirname(__FILE__) + '/units_helper'

describe "the GetAccountBalance API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = File.read("spec/mocks/GetAccountBalanceResponse.xml")

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
        @response.get_account_balance_result.account_balance.total_balance.value.should == 0
      end
    end
    
  end
end
