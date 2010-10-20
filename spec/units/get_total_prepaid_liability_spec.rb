require File.dirname(__FILE__) + '/units_helper'

describe "the GetTotalPrepaidLiability API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = doc = File.read("spec/mocks/GetTotalPrepaidLiabilityResponse.xml")
      
      @response = Remit::GetTotalPrepaidLiability::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_total_prepaid_liability_result.should be_an_kind_of Remit::GetTotalPrepaidLiability::Response::GetTotalPrepaidLiabilityResult
    end

    it "has outstanding prepaid liability" do
      @response.get_total_prepaid_liability_result.outstanding_prepaid_liability.should be_an_kind_of Remit::GetTotalPrepaidLiability::Response::GetTotalPrepaidLiabilityResult::OutstandingPrepaidLiability

    end
    
  end
end
