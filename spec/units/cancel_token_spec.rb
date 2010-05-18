require File.dirname(__FILE__) + '/units_helper'

describe "the GetTransaction API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <CancelTokenResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <ResponseMetadata>
            <RequestId>a10e0ad6-148f-4afe-8bcd-e80a2680793d:0</RequestId>
          </ResponseMetadata>
        </CancelTokenResponse>
      XML
      
      @response = Remit::CancelToken::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata
    end
    
    
  end
end