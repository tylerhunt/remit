require 'units/units_helper'

describe "the CancelSubscriptionAndRefund API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = File.read("spec/mocks/CancelSubscriptionAndRefundResponse.xml")
      
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
        @response.cancel_subscription_and_refund_result.refund_transaction_id.should == 'string'
      end
    end
    
    
  end
end
