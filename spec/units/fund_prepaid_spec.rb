require File.dirname(__FILE__) + '/units_helper'

describe "the FundPrepaid API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = File.read("spec/mocks/FundPrepaidResponse.xml")
      
      @response = Remit::FundPrepaid::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end

    describe "metadata" do
      it "has request_id" do
        @response.response_metadata.request_id
      end
    end
    
    it "has results" do
      @response.fund_prepaid_result.should_not be_nil
    end
    
    
  end
end
