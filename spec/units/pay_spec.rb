require File.dirname(__FILE__) + '/units_helper'

describe "the Pay API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-EXML
      <ns3:PayResponse xmlns:ns3="http://fps.amazonaws.com/doc/2007-01-08/">
        <ns3:TransactionResponse>
          <TransactionId>abc123</TransactionId>
          <Status>Initiated</Status>
        </ns3:TransactionResponse>
        <Status>Success</Status>
        <RequestId>foo</RequestId>
      </ns3:PayResponse>
      EXML
  
      @response = Remit::Pay::Response.new(doc)
    end
    
    it "has a transaction response" do
      @response.transaction_response.should_not be_nil
    end
    
    it "has a transaction id" do
      @response.transaction_response.transaction_id.should == 'abc123'
    end
    
    it "has a transaction status" do
      @response.transaction_response.status.should == 'Initiated'
    end
  end
end
