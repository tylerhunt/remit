require File.dirname(__FILE__) + '/units_helper'

describe "the GetTransaction API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before(:all) do
      doc = File.read("spec/mocks/GetTransactionResponse.xml")
      
      @response = Remit::GetTransaction::Response.new(doc)
    end
    
    it "has one transaction" do
      @response.transaction.should_not be_nil
    end
    
    describe "the result" do
      before(:all) do
        @transaction = @response.transaction
      end
      
      it "should have a transaction_id" do
        @transaction.transaction_id.should_not be_nil
      end
      
      it "should have caller_reference" do
        @transaction.caller_reference.should_not be_nil
      end
      
      it "should have caller_description" do
        @transaction.caller_description.should_not be_nil
      end
      
      it "should have date_received" do
        @transaction.date_received.should_not be_nil
      end
      
      it "should have date_completed" do
        @transaction.date_completed.should_not be_nil
      end
      
      it "should have transaction_amount" do
        @transaction.transaction_amount.should_not be_nil
      end
      
      it "should have transaction_amount.value" do
        @transaction.transaction_amount.value.should == 0
      end
      
      it "should have fps_fess_paid_by" do
        @transaction.fps_fees_paid_by.should_not be_nil
      end
      
      it "should have sender_token_id" do
        @transaction.sender_token_id.strip.should_not be_nil
      end
      
      it "should have fps_operation" do
        @transaction.fps_operation.should_not be_nil
      end
      
      it "should have payment_method" do
        @transaction.payment_method.should_not be_nil
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
      
      it "should have sender name" do
        @transaction.sender_name.should_not be_nil
      end
      
      it "should have sender email" do
        @transaction.sender_email.should_not be_nil
      end
      
      it "should have caller name" do
        @transaction.caller_name.should_not be_nil
      end
      
      it "should have recipient name" do
        @transaction.recipient_name.should_not be_nil
      end
      
      it "should have recipient email" do
        @transaction.recipient_email.should_not be_nil
      end
      
      it "reports the transaction's new status" do
        @result.transaction_status.should == 'Success'
      end
    end
  end
end
