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
    before do
      doc = <<-XML
        <?xml version=\"1.0\"?>
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
      @error = @response.errors.first
    end

    it_should_behave_like 'a failed response'

    describe "with an invalid params error" do
      it "should be a service error" do
        @error.should be_kind_of(Remit::ServiceError)
      end

      it "should have an error type of 'Business'" do
        @error.error_type.should == 'Business'
      end

      it "should have an error code of 'InvalidParams'" do
        @error.error_code.should == 'InvalidParams'
      end

      it "should not be retriable" do
        @error.is_retriable.should == 'false'
      end

      it "should have reason text" do
        @error.reason_text.should == 'callerTokenId can not be empty'
      end
    end
  end

  describe "for a failed request" do
    before do
      doc = <<-XML
        <?xml version=\"1.0\"?>
        <ns3:PayResponse xmlns:ns3=\"http://fps.amazonaws.com/doc/2007-01-08/\">
          <Status>Failure</Status>
          <Errors>
            <Errors>
              <ErrorType>Business</ErrorType>
              <IsRetriable>false</IsRetriable>
              <ErrorCode>TokenUsageError</ErrorCode>
              <ReasonText>The token \"45XU7TLBN995ZQA2U1PS1ZCTJXJMJ3H1GH6VZAB82C1BGLK9X3AXUQDA3QDLJVPX\" has violated its usage policy.</ReasonText>
              </Errors>
            </Errors>
            <RequestId>78acff80-b740-4b57-9301-18d0576e6855:0
          </RequestId>
        </ns3:PayResponse>
      XML

      @response = Remit::Pay::Response.new(doc)
      @error = @response.errors.first
    end

    it_should_behave_like 'a failed response'

    describe "with a token usage error" do
      it "should be a service error" do
        @error.should be_kind_of(Remit::ServiceError)
      end

      it "should have an error type of 'Business'" do
        @error.error_type.should == 'Business'
      end

      it "should have an error code of 'TokenUsageError'" do
        @error.error_code.should == 'TokenUsageError'
      end

      it "should not be retriable" do
        @error.is_retriable.should == 'false'
      end

      it "should have reason text" do
        @error.reason_text.should == 'The token "45XU7TLBN995ZQA2U1PS1ZCTJXJMJ3H1GH6VZAB82C1BGLK9X3AXUQDA3QDLJVPX" has violated its usage policy.'
      end
    end
  end
end
