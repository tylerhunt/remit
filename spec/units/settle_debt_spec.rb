require File.dirname(__FILE__) + '/units_helper'

describe "the SettleDebt API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <SettleDebtResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <SettleDebtResult>
            <TransactionId>14GK6F2QU755ODS27SGHEURLKPG72Z54KMF</TransactionId>
            <TransactionStatus>Pending</TransactionStatus>
          </SettleDebtResult>
          <ResponseMetadata>
            <RequestId>1a146b9a-b37b-4f5f-bda6-012a5b9e45c3:0</RequestId>
          </ResponseMetadata>
        </SettleDebtResponse>
      XML
      
      @response = Remit::SettleDebt::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.settle_debt_result.should_not be_nil
    end
    
    
    it "has a transaction id" do
      @response.settle_debt_result.transaction_id.should_not be_nil
    end

    it "has a transaction status" do
      @response.settle_debt_result.transaction_status.should_not be_nil
    end
    
  end
end