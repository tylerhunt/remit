require File.dirname(__FILE__) + '/integrations_helper'

describe 'a Pay call' do

  it_should_behave_like 'a successful response'

  before(:all) do
    @response = remit.get_tokens

  end

  it 'should have a collection of tokens' do
    @response.get_tokens_result.should have_at_least(1).tokens
  end

end
