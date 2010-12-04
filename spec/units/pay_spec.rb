require File.dirname(__FILE__) + '/units_helper'

describe "the Pay API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'

    before do
      doc = <<-XML
      <PayResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
         <PayResult>
            <TransactionId>abc123</TransactionId>
            <TransactionStatus>Success</TransactionStatus>
         </PayResult>
         <ResponseMetadata>
            <RequestId>foo-bar</RequestId>
         </ResponseMetadata>
      </PayResponse>
      XML

      @response = Remit::Pay::Response.new(doc)
    end

    it "has a transaction response" do
      @response.pay_result.should_not be_nil
    end

    it "has a transaction id" do
      @response.pay_result.transaction_id.should == 'abc123'
    end

    it "has a transaction status" do
      @response.pay_result.transaction_status.should == 'Success'
    end

    #it "has status shortcuts" do
    #  @response.pay_result.should be_initiated
    #end
  end

  describe "for a pending request" do
    before do
      doc = <<-XML
        <PayResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
           <PayResult>
              <TransactionId>14GK6BGKA7U6OU6SUTNLBI5SBBV9PGDJ6UL</TransactionId>
              <TransactionStatus>Pending</TransactionStatus>
           </PayResult>
           <ResponseMetadata>
              <RequestId>c21e7735-9c08-4cd8-99bf-535a848c79b4:0</RequestId>
           </ResponseMetadata>
        </PayResponse>
      XML

      @response = Remit::Pay::Response.new(doc)
      @error = @response.errors.first
    end

    it_should_behave_like 'a pending response'

  end

  describe "for a failed request" do
    before do
      doc = <<-XML
        <PayResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <PayResult>
            <TransactionId>14GK6BGKA7U6OU6SUTNLBI5SBBV9PGDJ6UL</TransactionId>
            <TransactionStatus>Pending</TransactionStatus>
          </PayResult>
          <ResponseMetadata>
            <RequestId>c21e7735-9c08-4cd8-99bf-535a848c79b4:0</RequestId>
          </ResponseMetadata>
          <Errors>
            <Errors>
              <ErrorType>Business</ErrorType>
              <IsRetriable>false</IsRetriable>
              <ErrorCode>TokenUsageError</ErrorCode>
              <ReasonText>The token "45XU7TLBN995ZQA2U1PS1ZCTJXJMJ3H1GH6VZAB82C1BGLK9X3AXUQDA3QDLJVPX" has violated its usage policy.</ReasonText>
            </Errors>
          </Errors>
        </PayResponse>
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
