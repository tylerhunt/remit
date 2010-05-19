require File.dirname(__FILE__) + '/integrations_helper'

describe 'a GetTokens call' do
  it_should_behave_like 'a successful response'

  before(:all) do
    @response = remit.get_tokens
    
  end

  it 'should have a collection of tokens' do
    @response.get_tokens_result.should have_at_least(1).tokens
  end

  it 'should have a token with all of its values set' do
    token = @response.get_tokens_result.tokens.first
    token.token_id.should_not be_empty
    token.friendly_name.should_not be_empty
    token.token_status.should_not be_empty
    token.date_installed.should_not be_nil
    #token.caller_installed.should_not be_empty
    token.caller_reference.should_not be_empty
    token.token_type.should_not be_empty
    token.old_token_id.should_not be_empty
    #token.payment_reason.should be_empty
  end

  it 'should have a token with a token ID' do
    @response.get_tokens_result.tokens.first.token_id.should_not be_empty
  end

  it 'should have a token with a valid token status' do
    @response.get_tokens_result.tokens.first.token_status.should match(/^(IN)?ACTIVE$/i)
  end

  it 'should have a token with a valid installation date' do
    @response.get_tokens_result.tokens.first.date_installed.should be_a_kind_of(Time)
  end
end
