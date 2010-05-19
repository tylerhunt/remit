require File.dirname(__FILE__) + '/units_helper'

describe "the CancelSubscriptionAndRefund API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <CancelSubscriptionAndRefundResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <CancelSubscriptionAndRefundResult>
            <RefundTransactionId>14GKE3B85HCMF1BTSH5C4PD2IHZL95RJ2LM</RefundTransactionId>
          </CancelSubscriptionAndRefundResult>
          <ResponseMetadata>
            <RequestId>bfbc0b1e-3430-4a74-a75e-5292f59107ca:0</RequestId>
          </ResponseMetadata>
        </CancelSubscriptionAndRefundResponse>
      XML
      
      @response = Remit::CancelSubscriptionAndRefund::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata
    end
    
    it "has results" do
      @response.cancel_subscription_and_refund_result.should_not be_nil
    end
    
    describe "the result" do
      it "should have refund_transaction_id" do
        @response.cancel_subscription_and_refund_result.refund_transaction_id.should == '14GKE3B85HCMF1BTSH5C4PD2IHZL95RJ2LM'
      end
    end
    
    
  end
end