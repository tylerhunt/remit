require File.dirname(__FILE__) + '/units_helper'

describe "the GetResults API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'

    before do
      doc = <<-XML
        <?xml version=\"1.0\"?>
        <ns3:GetResultsResponse xmlns:ns3=\"http://fps.amazonaws.com/doc/2007-01-08/\">
          <TransactionResults>
            <TransactionId>abc123</TransactionId>
            <Operation>Pay</Operation>
            <CallerReference>1827</CallerReference>
            <Status>Success</Status>
          </TransactionResults>
          <NumberPending>1</NumberPending>
          <Status>Success</Status>
          <RequestId>f89727ba-9ff6-4ca8-87a3-0fd6c9de6b95:0</RequestId>
        </ns3:GetResultsResponse>
      XML

      @response = Remit::GetResults::Response.new(doc)
    end

    it "has one result" do
      @response.number_pending.should == 1
      @response.transaction_results.size == "1"
    end

    describe "the result" do
      before do
        @result = @response.transaction_results.first
      end

      it "references a previous transaction" do
        @result.transaction_id.should == "abc123"
      end

      it "references a pay transaction" do
        @result.operation_type.should == 'Pay'
      end

      it "reports the transaction's new status" do
        @result.transaction_status.should == 'Success'
      end
    end
  end
end
