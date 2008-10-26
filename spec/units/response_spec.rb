require File.dirname(__FILE__) + '/units_helper'

describe "the response object" do
  describe "for a successful request" do
    
  end

  describe "for a failed request" do
    before do
      doc = "
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
      </ns3:PayResponse>"
      @response = Remit::Response.new(doc)
    end
    
    it "is not successful" do
      @response.should_not be_successful
    end
    
    it "has a request id" do
      @response.request_id.should_not be_nil
      @response.request_id.should_not be_empty
    end
    
    it "has errors" do
      @response.errors.should_not be_empty
      error = @response.errors.first
      error.error_type.should == "Business"
      error.is_retriable.should == 'false'
      error.error_code.should == "InvalidParams"
      error.reason_text.should == 'callerTokenId can not be empty'
    end
  end
end
