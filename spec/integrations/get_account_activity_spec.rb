require File.dirname(__FILE__) + '/integrations_helper'

describe 'a GetAccountActivity call' do
  it_should_behave_like 'a successful response'

  before(:all) do
    request = Remit::GetAccountActivity::Request.new
    request.start_date = Date.today - 7
    @response = remit.get_account_activity(request)
  end

  it 'should have a collection of transactions' do
    @response.should have_at_least(1).transactions
  end

  it 'should have a transaction with all of its values set' do
    transaction = @response.transactions.first
    transaction.caller_name.should_not be_empty
    transaction.caller_token_id.should_not be_empty
    transaction.caller_transaction_date.should_not be_nil
    transaction.date_completed.should_not be_nil
    transaction.date_received.should_not be_nil
    transaction.error_code.should be_empty
    transaction.error_detail.should be_nil
    transaction.error_message.should be_nil
    transaction.fees.should_not be_nil
    transaction.operation.should_not be_empty
    transaction.recipient_name.should_not be_empty
    transaction.sender_name.should_not be_empty
    transaction.sender_token_id.should_not be_empty
    transaction.status.should_not be_empty
    transaction.transaction_amount.should_not be_nil
    transaction.transaction_id.should_not be_empty
    transaction.transaction_parts.should_not be_empty
  end
end
