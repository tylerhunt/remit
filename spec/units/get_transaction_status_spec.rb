require File.dirname(__FILE__) + '/units_helper'

describe "the GetTransaction API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetTransactionStatusResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <GetTransactionStatusResult>
            <TransactionId>14GKE3B85HCMF1BTSH5C4PD2IHZL95RJ2LM</TransactionId>
            <TransactionStatus>Success</TransactionStatus>
            <CallerReference>CallerReference07</CallerReference>
            <StatusCode>Success</StatusCode>
            <StatusMessage>
              The transaction was successful and the payment instrument was charged.
            </StatusMessage>
          </GetTransactionStatusResult>
          <ResponseMetadata>
            <RequestId>13279842-6f84-41ef-ae36-c1ededaf278d:0</RequestId>
          </ResponseMetadata>
        </GetTransactionStatusResponse>
      XML
      
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
        @transaction.transaction_id.should == "14GKE3B85HCMF1BTSH5C4PD2IHZL95RJ2LM"
      end
      
      
      it "should have transaction_status" do
        @transaction.transaction_status.should == "Success"
      end
      
      it "should have status_code" do
        @transaction.status_code.should == "Success"
      end
      
      it "should have status_message" do
        @transaction.status_message.should_not be_nil
      end
      
      
      #
      #      it "reports the transaction's new status" do
      #        @result.transaction_status.should == 'Success'
      #      end
    end
  end
end