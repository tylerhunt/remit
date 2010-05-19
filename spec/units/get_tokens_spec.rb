require File.dirname(__FILE__) + '/units_helper'

describe "the GetTokens API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetTokensResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
           <GetTokensResult>
            <Token>
             <TokenId>
              D439DTSTMP4FK9NBL6PEKZWAPGRDZ2BDX3MJNGVX37EF3GA7XRQHMEELQOGFZ9GK
             </TokenId>
             <TokenStatus>Active</TokenStatus>
             <DateInstalled>2009-10-07T04:37:57.375-07:00</DateInstalled>
             <CallerReference>CallerReference12</CallerReference>
             <TokenType>SingleUse</TokenType>
             <OldTokenId>
              D439DTSTMP4FK9NBL6PEKZWAPGRDZ2BDX3MJNGVX37EF3GA7XRQHMEELQOGFZ9GK
             </OldTokenId>
            </Token>
           </GetTokensResult>
           <ResponseMetadata>
            <RequestId>c9db3c80-ff03-4a32-b6b6-ee071cd118c8:0</RequestId>
           </ResponseMetadata>
          </GetTokensResponse>
      XML
      
      @response = Remit::GetTokens::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_tokens_result.should_not be_nil
    end
    
    
    describe "the result" do
      it "should have  a token_id" do
        @response.get_tokens_result.tokens.first.token_id.should_not be_nil
      end
    end
    
  end
end