require File.dirname(__FILE__) + '/units_helper'

describe "the GetTransaction API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = File.read("spec/mocks/GetTransactionStatusResponse.xml")
      
      @response = Remit::GetTransactionStatus::Response.new(doc)
    end
    
    it "has one transaction" do
      @response.get_transaction_status_result.should_not be_nil
    end
    
    describe "the result" do
      before do
        @transaction = @response.get_transaction_status_result
      end
      
      it "should have a transaction_id" do
        @transaction.transaction_id.should_not be_nil
      end
      
      
      it "should have transaction_status" do
        @transaction.transaction_status.should_not be_nil
      end
      
      it "should have status_code" do
        @transaction.status_code.should_not be_nil
      end
      
      it "should have status_message" do
        @transaction.status_message.should_not be_nil
      end
      
      it "reports the transaction's new status" do
        @transaction.transaction_status.should_not be_nil
      end
    end
  end
end
