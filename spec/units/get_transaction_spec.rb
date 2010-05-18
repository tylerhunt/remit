require File.dirname(__FILE__) + '/units_helper'

describe "the GetTransaction API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetTransactionResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <GetTransactionResult>
            <Transaction>
              <TransactionId>14GK6BGKA7U6OU6SUTNLBI5SBBV9PGDJ6UL</TransactionId>
              <CallerReference>CallerReference02</CallerReference>
              <CallerDescription>MyWish</CallerDescription>
              <DateReceived>2009-10-05T22:50:08.010-07:00</DateReceived>
              <DateCompleted>2009-10-05T22:50:09.086-07:00</DateCompleted>
              <TransactionAmount>
                <CurrencyCode>USD</CurrencyCode>
                <Value>1.000000</Value>
              </TransactionAmount>
              <FPSFees>
                <CurrencyCode>USD</CurrencyCode>
                <Value>0.100000</Value>
              </FPSFees>
              <FPSFeesPaidBy>Recipient</FPSFeesPaidBy>
              <SenderTokenId>
                553ILMLCG6Z8J431H7BX3UMN3FFQU8VSNTSRNCTAASDJNX66LNZLKSZU3PI7TXIH
              </SenderTokenId>
              <FPSOperation>Pay</FPSOperation>
              <PaymentMethod>CC</PaymentMethod>
              <TransactionStatus>Success</TransactionStatus>
              <StatusCode>Success</StatusCode>
              <StatusMessage>
                The transaction was successful and the payment instrument was charged.
              </StatusMessage>
              <SenderName>Test Business</SenderName>
              <SenderEmail>new_premium@amazon.com</SenderEmail>
              <CallerName>Test Business</CallerName>
              <RecipientName>Test Business</RecipientName>
              <RecipientEmail>test-caller@amazon.com</RecipientEmail>
              <StatusHistory>
                <Date>2009-10-05T22:50:08.092-07:00</Date>
                <TransactionStatus>Pending</TransactionStatus>
                <StatusCode>PendingNetworkResponse</StatusCode>
              </StatusHistory>
              <StatusHistory>
                <Date>2009-10-05T22:50:09.086-07:00</Date>
                <TransactionStatus>Success</TransactionStatus>
                <StatusCode>Success</StatusCode>
              </StatusHistory>
            </Transaction>
          </GetTransactionResult>
          <ResponseMetadata>
            <RequestId>0702960e-8221-4e04-9413-ca7d010d3b06:0</RequestId>
          </ResponseMetadata>
        </GetTransactionResponse>
      XML
      
      @response = Remit::GetTransaction::Response.new(doc)
    end
    
    it "has one transaction" do
      @response.transaction.should_not be_nil
    end
    
    describe "the result" do
      before do
        @transaction = @response.transaction
      end
      
      it "should have a transaction_id" do
        @transaction.transaction_id.should == "14GK6BGKA7U6OU6SUTNLBI5SBBV9PGDJ6UL"
      end
      
      it "should have caller_reference" do
        @transaction.caller_reference.should == 'CallerReference02'
      end
      
      it "should have caller_description" do
        @transaction.caller_description.should == 'MyWish'
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
        @transaction.transaction_amount.value.should == 1
      end
      
      it "should have fps_fess_paid_by" do
        @transaction.fps_fees_paid_by.should == "Recipient"
      end
      
      it "should have sender_token_id" do
        @transaction.sender_token_id.strip.should == "553ILMLCG6Z8J431H7BX3UMN3FFQU8VSNTSRNCTAASDJNX66LNZLKSZU3PI7TXIH"
      end
      
      it "should have fps_operation" do
        @transaction.fps_operation.should == "Pay"
      end
      
      it "should have payment_method" do
        @transaction.payment_method.should == "CC"
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
      
      it "should have sender name" do
        @transaction.sender_name.should == 'Test Business'
      end
      
      it "should have sender email" do
        @transaction.sender_email.should == 'new_premium@amazon.com'
      end
      
      it "should have caller name" do
        @transaction.caller_name.should == 'Test Business'
      end
      
      it "should have recipient name" do
        @transaction.recipient_name.should == 'Test Business'
      end
      
      it "should have recipient email" do
        @transaction.recipient_email.should == 'test-caller@amazon.com'
      end
      
      #
      #      it "reports the transaction's new status" do
      #        @result.transaction_status.should == 'Success'
      #      end
    end
  end
end