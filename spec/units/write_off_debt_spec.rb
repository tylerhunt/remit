require File.dirname(__FILE__) + '/units_helper'

describe "the WriteOffDebt API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <WriteOffDebtResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <WriteOffDebtResult>
            <TransactionId>14GK6F2QU755ODS27SGHEURLKPG72Z54KMF</TransactionId>
            <TransactionStatus>Pending</TransactionStatus>
          </WriteOffDebtResult>
          <ResponseMetadata>
            <RequestId>1a146b9a-b37b-4f5f-bda6-012a5b9e45c3:0</RequestId>
          </ResponseMetadata>
        </WriteOffDebtResponse>
      XML
      
      @response = Remit::WriteOffDebt::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.write_off_debt_result.should_not be_nil
    end
    
    
    it "has a transaction id" do
      @response.write_off_debt_result.transaction_id.should_not be_nil
    end

    it "has a transaction status" do
      @response.write_off_debt_result.transaction_status.should_not be_nil
    end
    
  end
end