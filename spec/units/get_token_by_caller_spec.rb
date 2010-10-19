require File.dirname(__FILE__) + '/units_helper'

describe "the GetTokenByCaller API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before(:all) do
      doc = File.read("spec/mocks/GetTokenByCallerResponse.xml")
      
      @response = Remit::GetTokenByCaller::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_token_by_caller_result.should_not be_nil
    end
    
    it "should have Token" do
      @response.get_token_by_caller_result.token.should_not be_nil
    end

    describe "has Token" do
      before(:all) do
        @token = @response.get_token_by_caller_result.token
      end
      it "should have TokenId" do
        @token.token_id.should_not be_nil
      end
      it "should have FriendlyName" do
        @token.friendly_name.should_not be_nil
      end
      it "should have TokenStatus" do
        @token.token_status.should_not be_nil
      end
      it "should have DateInstalled" do
        @token.date_installed.should_not be_nil
      end
      it "should have CallerReference" do
        @token.caller_reference.should_not be_nil
      end
      it "should have TokenType" do
        @token.token_type.should_not be_nil
      end
      it "should have OldTokenId" do
        @token.old_token_id.should_not be_nil
      end
      it "should have PaymentReason" do
        @token.payment_reason.should_not be_nil
      end
    end

  end
end
