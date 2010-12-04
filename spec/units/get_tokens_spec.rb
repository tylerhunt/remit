require File.dirname(__FILE__) + '/units_helper'

describe "the GetTokens API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before(:all) do
      doc = File.read("spec/mocks/GetTokensResponse.xml") 
      
      @response = Remit::GetTokens::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_tokens_result.should_not be_nil
    end

    it "should have tokens" do
      @response.get_tokens_result.tokens.length.should > 0
    end

    describe "Tokens" do
      before(:all) do
        @token = @response.get_tokens_result.tokens.first
      end
      it "should have a TokenId" do
        @token.token_id.should_not be_nil
      end
      it "should have a FriendlyName" do
        @token.friendly_name.should_not be_nil
      end
      it "should have a TokenStatus" do
        @token.token_status.should_not be_nil
      end
      it "should have a DateInstalled" do
        @token.date_installed.should_not be_nil
      end
      it "should have a CallerReference" do
        @token.caller_reference.should_not be_nil
      end
      it "should have a TokenType" do
        @token.token_type.should_not be_nil
      end
      it "should have a OldTokenId" do
        @token.old_token_id.should_not be_nil
      end
      it "should have a PaymentReason" do
        @token.payment_reason.should_not be_nil
      end
    end

  end
end
