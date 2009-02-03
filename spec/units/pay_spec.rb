require File.dirname(__FILE__) + '/units_helper'

describe "the Pay API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'

    before do
      doc = <<-XML
        <ns3:PayResponse xmlns:ns3="http://fps.amazonaws.com/doc/2007-01-08/">
          <ns3:TransactionResponse>
            <TransactionId>abc123</TransactionId>
            <Status>Initiated</Status>
          </ns3:TransactionResponse>
          <Status>Success</Status>
          <RequestId>foo</RequestId>
        </ns3:PayResponse>
      XML

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

    it "has status shortcuts" do
      @response.transaction_response.should be_initiated
    end
  end

  describe "for a failed request" do
    it_should_behave_like 'a failed response'

    before do
      doc = <<-XML
        <ns3:PayResponse xmlns:ns3=\"http://fps.amazonaws.com/doc/2007-01-08/\">
          <Status>Failure</Status>
          <Errors>
            <Errors>
              <ErrorType>Business</ErrorType>
              <IsRetriable>false</IsRetriable>
              <ErrorCode>InvalidParams</ErrorCode>
              <ReasonText>callerTokenId can not be empty</ReasonText>
            </Errors>
          </Errors>
          <RequestId>7966a2d9-5ce9-4902-aefc-b01d254c931a:0</RequestId>
        </ns3:PayResponse>
      XML

      @response = Remit::Pay::Response.new(doc)
    end

    it "has error details" do
      error = @response.errors.first
      error.should be_kind_of(Remit::ServiceError)
      error.error_type.should == 'Business'
      error.is_retriable.should == 'false'
      error.error_code.should == 'InvalidParams'
      error.reason_text.should == 'callerTokenId can not be empty'
    end
  end
end
