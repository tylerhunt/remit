require File.dirname(__FILE__) + '/units_helper'

describe "the GetTokenByCaller API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetTokenByCallerResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <GetTokenByCallerResult>
            <Token>
              <TokenId>
                543IJMECGZZ3J4K1F7BJ3TMNXFBQU9VXNT7RRCTNAJDJ8X36L1ZRKSUUPPIBTTIK
              </TokenId>
              <FriendlyName>Friendly1339359778</FriendlyName>
              <TokenStatus>Active</TokenStatus>
              <DateInstalled>2009-10-07T04:29:05.054-07:00</DateInstalled>
              <CallerReference>callerReferenceSingleUse10</CallerReference>
              <TokenType>SingleUse</TokenType>
              <OldTokenId>
                543IJMECGZZ3J4K1F7BJ3TMNXFBQU9VXNT7RRCTNAJDJ8X36L1ZRKSUUPPIBTTIK
              </OldTokenId>
              <PaymentReason>PaymentReason</PaymentReason>
            </Token>
          </GetTokenByCallerResult>
          <ResponseMetadata>
            <RequestId>45b6c560-8aa9-463c-84be-80eeefb21034:0</RequestId>
          </ResponseMetadata>
        </GetTokenByCallerResponse>
      XML
      
      @response = Remit::GetTokenByCaller::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_token_by_caller_result.should_not be_nil
    end
    
    
  end
end