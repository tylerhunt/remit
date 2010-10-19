require File.dirname(__FILE__) + '/units_helper'

describe "the GetTransaction API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = File.read("spec/mocks/CancelTokenResponse.xml")

      @response = Remit::CancelToken::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata
    end

    describe "metadata" do
      it "has request_id" do
        @response.response_metadata.request_id
      end
    end

  end
end
